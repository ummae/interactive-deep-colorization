# coding=utf-8
import os
os.environ['PYCAFFE_ROOT'] = "/opt/caffe/python"
os.environ['CAFFE_ROOT'] = "/opt/caffe"
os.environ['PYTHONPATH'] += "/opt/caffe/python"

import caffe

import sys
import argparse
import time
import base64
import cv2
from skimage import color
import ujson as json
from collections import defaultdict

import bottle
import logging

import numpy
from bottle import route, run, template, redirect, static_file

from data import colorize_image as CI


LEADING_ZEROS_COUNT = 15
logging.basicConfig(stream=sys.stdout, level=logging.DEBUG, format='%(asctime)s %(levelname)s %(message)s')
bottle.BaseRequest.MEMFILE_MAX = 1024 * 1024 * 1024
app = bottle.app()

images_by_uuid = defaultdict(dict)


@route('/deepcolor')
@route('/deepcolor/')
@route('/deepcolor/webui')
@route('/deepcolor/webui/')
def index():
    token = str(int(time.time() * 1000)).zfill(LEADING_ZEROS_COUNT)
    return template('html/webui.tpl', {
        'token': token
    })


@route('/deepcolor/upload', method=['POST'])
def upload_image():
    qquuid, qqfile = bottle.request.POST['qquuid'], bottle.request.POST['qqfile']
    filestr = qqfile.file.read()
    nparr = numpy.fromstring(filestr, numpy.uint8)
    images_by_uuid[qquuid]['original'] = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
    images_by_uuid[qquuid]['grayscale'] = cv2.cvtColor(images_by_uuid[qquuid]['original'], cv2.COLOR_BGR2GRAY)

    # generate color model without user interaction
    colorModel.set_image(cv2.cvtColor(images_by_uuid[qquuid]['grayscale'], cv2.COLOR_GRAY2RGB))
    mask = numpy.zeros((1, 256, 256))  # giving no user points, so mask is all 0's
    input_ab = numpy.zeros((2, 256, 256))  # ab values of user points, default to 0 for no input
    colorModel.net_forward(input_ab, mask)  # run model, returns 256x256 image

    images_by_uuid[qquuid]['result'] = cv2.cvtColor(colorModel.get_img_fullres(), cv2.COLOR_RGB2BGR)

    return json.dumps({
        'success': True,
        'qquuid': qquuid,
        'img_grayscale': 'data:image/jpeg;base64,' + base64.encodestring(cv2.imencode('.jpg', images_by_uuid[qquuid]['grayscale'])[1].tostring()),
        'img_result': 'data:image/jpeg;base64,' + base64.encodestring(cv2.imencode('.jpg', images_by_uuid[qquuid]['result'])[1].tostring())
    })


@route('/deepcolor/recommend', method=['POST'])
def recommend():
    qquuid = bottle.request.POST['qquuid']
    halfpatch = int(bottle.request.POST.get('patch', 3))
    x = int(bottle.request.POST['x'])
    y = int(bottle.request.POST['y'])
    hints_str = bottle.request.POST['hints']
    hints = json.loads(hints_str)  # x, y, r, g, b
    K = 6

    mask = numpy.zeros((1, 256, 256))  # giving no user points, so mask is all 0's
    input_ab = numpy.zeros((2, 256, 256))  # ab values of user points, default to 0 for no input

    for _x, _y, r, g, b in hints:
        if r is None:
            continue
        l, a, b = rgb2lab([r, g, b])
        put_point(input_ab, mask, (_y, _x), halfpatch, (a, b))

    colorModel.set_image(cv2.cvtColor(images_by_uuid[qquuid]['grayscale'], cv2.COLOR_GRAY2RGB))
    colorModel.net_forward(input_ab, mask)  # run model, returns 256x256 image
    rs = colorModel.get_ab_reccs(h=y, w=x, K=6)

    im_lab = color.rgb2lab(cv2.cvtColor(cv2.resize(images_by_uuid[qquuid]['original'], (256, 256)), cv2.COLOR_RGB2BGR)[:, :, ::-1])
    L = numpy.tile(im_lab[y, x, 0], (K, 1))
    rgbs = []
    # for r in rs:
    colors_lab = numpy.concatenate((L, rs), axis=1)
    colors_lab3 = colors_lab[:, numpy.newaxis, :]
    colors_rgb = numpy.clip(numpy.squeeze(color.lab2rgb(colors_lab3)), 0, 1.0) * 255
    # rgbs.append(colors_rgb)

    bottle.response.content_type = 'application/json'
    return json.dumps({
        'success': True,
        'qquuid': qquuid,
        'r': colors_rgb
    })


@route('/deepcolor/colorize', method=['POST'])
def colorize():
    qquuid = bottle.request.POST['qquuid']
    halfpatch = int(bottle.request.POST.get('patch', 3))
    hints_str = bottle.request.POST['hints']
    hints = json.loads(hints_str)       # x, y, r, g, b

    mask = numpy.zeros((1, 256, 256))  # giving no user points, so mask is all 0's
    input_ab = numpy.zeros((2, 256, 256))  # ab values of user points, default to 0 for no input

    for x, y, r, g, b in hints:
        if r is None:
            continue
        l, a, b = rgb2lab([r, g, b])
        put_point(input_ab, mask, (y, x), halfpatch, (a, b))

    colorModel.set_image(cv2.cvtColor(images_by_uuid[qquuid]['grayscale'], cv2.COLOR_GRAY2RGB))
    colorModel.net_forward(input_ab, mask)  # run model, returns 256x256 image
    images_by_uuid[qquuid]['result'] = cv2.cvtColor(colorModel.get_img_fullres(), cv2.COLOR_RGB2BGR)

    bottle.response.content_type = 'application/json'
    return json.dumps({
        'success': True,
        'qquuid': qquuid,
        'img_result': 'data:image/jpeg;base64,' + base64.encodestring(
            cv2.imencode('.jpg', images_by_uuid[qquuid]['result'])[1].tostring())
    })


@route('/deepcolor/transfer', method=['POST'])
def histogram_transfer():
    pass


@route('/deepcolor/download')
def download_image():
    pass


@route('/deepcolor/static/<path:path>')
def statics(path):
    return static_file(path, root='./html/')


# def rgb2lab(r, g, b):
#     return _rgb2lab([(r, g, b)])[0]


def put_point(input_ab, mask, loc, p, val):
    # input_ab    2x256x256    current user ab input (will be updated)
    # mask        1x256x256    binary mask of current user input (will be updated)
    # loc         2 tuple      (h,w) of where to put the user input
    # p           scalar       half-patch size
    # val         2 tuple      (a,b) value of user input
    input_ab[:, loc[0] - p:loc[0] + p + 1, loc[1] - p:loc[1] + p + 1] = numpy.array(val)[:, numpy.newaxis, numpy.newaxis]
    mask[:, loc[0] - p:loc[0] + p + 1, loc[1] - p:loc[1] + p + 1] = 1
    return (input_ab, mask)


def rgb2lab(inputColor):
    num = 0
    RGB = [0, 0, 0]

    for value in inputColor:
        value = float(value) / 255

        if value > 0.04045:
            value = ((value + 0.055) / 1.055) ** 2.4
        else:
            value = value / 12.92

        RGB[num] = value * 100
        num = num + 1

    XYZ = [0, 0, 0, ]

    X = RGB[0] * 0.4124 + RGB[1] * 0.3576 + RGB[2] * 0.1805
    Y = RGB[0] * 0.2126 + RGB[1] * 0.7152 + RGB[2] * 0.0722
    Z = RGB[0] * 0.0193 + RGB[1] * 0.1192 + RGB[2] * 0.9505
    XYZ[0] = round(X, 4)
    XYZ[1] = round(Y, 4)
    XYZ[2] = round(Z, 4)

    XYZ[0] = float(XYZ[0]) / 95.047  # ref_X =  95.047   Observer= 2°, Illuminant= D65
    XYZ[1] = float(XYZ[1]) / 100.0  # ref_Y = 100.000
    XYZ[2] = float(XYZ[2]) / 108.883  # ref_Z = 108.883

    num = 0
    for value in XYZ:
        if value > 0.008856:
            value = value ** (0.3333333333333333)
        else:
            value = (7.787 * value) + (16 / 116)

        XYZ[num] = value
        num = num + 1

    Lab = [0, 0, 0]

    L = (116 * XYZ[1]) - 16
    a = 500 * (XYZ[0] - XYZ[1])
    b = 200 * (XYZ[1] - XYZ[2])

    Lab[0] = round(L, 4)
    Lab[1] = round(a, 4)
    Lab[2] = round(b, 4)

    return Lab


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='BrainCloud Scheduler App')
    parser.add_argument('--port', type=int, help='web port', default=9090)
    # parser.add_argument('--redis-host', type=str, help='cache redis host',
    #                     default='31197.rc2-colorization-dev.service.mokdong.consul')
    # parser.add_argument('--redis-port', type=int, help='cache redis port', default=31197)
    # parser.add_argument('--redis-pass', type=str, help='cache redis password',
    #                     default='c59b6c9fe0d549ae876540e1fed7be17')
    args = parser.parse_args()

    # colorModel = CI.ColorizeImageCaffe(Xd=256)
    # colorModel.prep_net(0, './models/reference_model/deploy_nodist.prototxt', './models/reference_model/model.caffemodel')

    colorModel = CI.ColorizeImageCaffeDist(Xd=256)
    colorModel.prep_net(0, './models/reference_model/deploy_nopred.prototxt', './models/reference_model/model.caffemodel')

    print('http://brain-dev-gpu1.dakao.io:2205/deepcolor')
    run(host='0.0.0.0', port=args.port, debug=True)
