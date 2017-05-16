<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <script src='/deepcolor/static/spectrum/spectrum.js'></script>
    <link rel='stylesheet' href='/deepcolor/static/spectrum/spectrum.css' />

    <!-- File Uploader -->
    <!-- <link href="/deepcolor/static/file-uploader/fine-uploader-new.css" rel="stylesheet"> -->
    <link href="/deepcolor/static/file-uploader/fine-uploader-gallery.css" rel="stylesheet">

    <!-- Fine Uploader jQuery JS file
    ====================================================================== -->
    <script src="/deepcolor/static/file-uploader/fine-uploader.js"></script>

    <!-- Fine Uploader Gallery template
    ====================================================================== -->
    <script type="text/template" id="qq-template-gallery">
        <div class="qq-uploader-selector qq-uploader qq-gallery" qq-drop-area-text="Drop files here">
            <div class="qq-total-progress-bar-container-selector qq-total-progress-bar-container">
                <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-total-progress-bar-selector qq-progress-bar qq-total-progress-bar"></div>
            </div>
            <div class="qq-upload-drop-area-selector qq-upload-drop-area" qq-hide-dropzone>
                <span class="qq-upload-drop-area-text-selector"></span>
            </div>
            <div class="qq-upload-button-selector qq-upload-button">
                <div>Upload a file</div>
            </div>
            <span class="qq-drop-processing-selector qq-drop-processing">
                <span>Processing dropped files...</span>
                <span class="qq-drop-processing-spinner-selector qq-drop-processing-spinner"></span>
            </span>
            <ul class="qq-upload-list-selector qq-upload-list" role="region" aria-live="polite" aria-relevant="additions removals">
                <li>
                    <span role="status" class="qq-upload-status-text-selector qq-upload-status-text"></span>
                    <div class="qq-progress-bar-container-selector qq-progress-bar-container">
                        <div role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" class="qq-progress-bar-selector qq-progress-bar"></div>
                    </div>
                    <span class="qq-upload-spinner-selector qq-upload-spinner"></span>
                    <div class="qq-thumbnail-wrapper">
                        <img class="qq-thumbnail-selector" width="120px" qq-max-size="120" qq-server-scale>
                        <img class="qq-gray-selector" width="120px" qq-max-size="120" qq-server-scale>
                        <img class="qq-result-selector" width="120px" qq-max-size="120" qq-server-scale>
                    </div>
                    <button type="button" class="qq-upload-cancel-selector qq-upload-cancel">X</button>
                    <button type="button" class="qq-upload-retry-selector qq-upload-retry">
                        <span class="qq-btn qq-retry-icon" aria-label="Retry"></span>
                        Retry
                    </button>

                    <div class="qq-file-info">
                        <div class="qq-file-name">
                            <span class="qq-upload-file-selector qq-upload-file"></span>
                            <span class="qq-edit-filename-icon-selector qq-edit-filename-icon" aria-label="Edit filename"></span>
                        </div>
                        <input class="qq-edit-filename-selector qq-edit-filename" tabindex="0" type="text" style="display: none;">
                        <!-- <button type="button" class="edit-btn hide btn">Edit</button> -->
                        <!-- <button type="button" class="hist-btn hide btn">Histogram</button> -->
                        <!-- <span class="qq-upload-size-selector qq-upload-size"></span> -->
                        <button type="button" class="qq-btn qq-upload-delete-selector qq-upload-delete">
                            <span class="qq-btn qq-delete-icon" aria-label="Delete"></span>
                        </button>
                        <button type="button" class="qq-btn qq-upload-pause-selector qq-upload-pause">
                            <span class="qq-btn qq-pause-icon" aria-label="Pause"></span>
                        </button>
                        <button type="button" class="qq-btn qq-upload-continue-selector qq-upload-continue">
                            <span class="qq-btn qq-continue-icon" aria-label="Continue"></span>
                        </button>
                    </div>
                </li>
            </ul>

            <dialog class="qq-alert-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Close</button>
                </div>
            </dialog>

            <dialog class="qq-confirm-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">No</button>
                    <button type="button" class="qq-ok-button-selector">Yes</button>
                </div>
            </dialog>

            <dialog class="qq-prompt-dialog-selector">
                <div class="qq-dialog-message-selector"></div>
                <input type="text">
                <div class="qq-dialog-buttons">
                    <button type="button" class="qq-cancel-button-selector">Cancel</button>
                    <button type="button" class="qq-ok-button-selector">Ok</button>
                </div>
            </dialog>
        </div>
    </script>
  </head>

  <body>

    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Deep Colorization</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Web UI</a></li>
            <li><a href="/deepcolor/webui">Start Over</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>



    <div class="container">
      <br/><br/>
      <div class="page-header">
        <div class="pull-left">
          <h4>Images</h4>
        </div>
        <div class="pull-right">
          <h6 class="text-right"><a href="#">Download Zip</a></h3>
        </div>
        <div class="clearfix"></div>
      </div>
      <div>
        <div id="fine-uploader-gallery"></div>

      </div>

      <div class="page-header">
        <h4>Options</h4>
      </div>
      <div>

      </div>

      <div class="page-header">
        <h4>Deep Colorization</h4>
      </div>
      <div>
        <div id="canvas" class="col-md-6">
          <img id="edit_gray_img" width=100%>
        </div>
        <div id="result" class="col-md-6">
          <img id="edit_result_img" width=100%>
        </div>
      </div>
    </div>

<style>
div#canvas, div#result {
  position: relative;
}

img#edit_gray_img, img#edit_result_img {
  position: absolute;
  left: 0;
  top: 0;
}

div.circle {
  width: 10px;
  height: 10px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
  position: absolute;
  /*background: red;*/
  cursor: pointer;
}
</style>

  </body>

  <script>
      var _id;
      var _qquuid;
      var _request_waiter;
      var _recent_color = [
        [255, 255, 255], [0, 0, 0], [255, 0, 0],
        [244, 209, 66], [66, 152, 244], [215, 244, 66]
      ];

      $(document).ready(function() {
        $('#edit_gray_img').click(function(e) {
          var offset = $(this).offset();

          var x = (e.pageX - offset.left - 5);
          var y = (e.pageY - offset.top - 5);
          var rx = Math.round((x / $(this).width()) * 255);
          var ry = Math.round((y / $(this).height()) * 255);

          var xyrgb = [];
          $.each($('div.circle'), function(key, value) {
            var vv = $(value);
            var rx = parseInt(vv.attr('rx'));
            var ry = parseInt(vv.attr('ry'));
            var r = parseInt(vv.attr('r'));
            var g = parseInt(vv.attr('g'));
            var b = parseInt(vv.attr('b'));
            xyrgb.push([rx, ry, r, g, b]);
          })

          var hints = JSON.stringify(xyrgb);

          $.ajax({
            url: '/deepcolor/recommend',
            type: 'POST',
            data: {
              hints: hints,
              qquuid: _qquuid,
              x: rx, y: ry
            },
            success: function(data) {
              if (data.success) {
                var c = $('<div class="circle"></div>');
                c.css('left', x.toString() + 'px');
                c.css('top', y.toString() + 'px');
                c.attr('rx', rx);
                c.attr('ry', ry);

                var _palette = []
                var _palette1 = []
                for (var i = 0; i < data.r.length; i ++) {
                  _palette1.push('rgb(' + data.r[i][0].toString() + ', ' + data.r[i][1].toString() + ', ' + data.r[i][2].toString() + ')')
                }
                _palette.push(_palette1)

                var _palette2 = []
                for (var i = 0; i < _recent_color.length; i ++) {
                  _palette2.push('rgb(' + _recent_color[i][0].toString() + ', ' + _recent_color[i][1].toString() + ', ' + _recent_color[i][2].toString() + ')')
                }
                _palette.push(_palette2)

                $('#canvas').append(c)
                c.spectrum({
                    showPalette: true,
                    palette: _palette,
                    hide: function(color) {
                      _recent_color.splice(0, 0, [color._r, color._g, color._b])
                      _recent_color = _recent_color.splice(0, 6)
                    },
                    change: function(color) {
                      c.css('background', color.toHexString());
                      c.attr('r', color._r);
                      c.attr('g', color._g);
                      c.attr('b', color._b);

                      upload_hints();
                    },
                    move: function(color) {
                      c.css('background', color.toHexString());
                      c.attr('r', color._r);
                      c.attr('g', color._g);
                      c.attr('b', color._b);

                      clearTimeout(_request_waiter);
                      _request_waiter = setTimeout(function() {
                        upload_hints();
                      }, 200)
                    },
                });
                c.spectrum("show");
              }
            }
          })


          // return false;
        })
      })

      var galleryUploader = new qq.FineUploader({
          element: document.getElementById("fine-uploader-gallery"),
          template: 'qq-template-gallery',
          request: {
              endpoint: '/deepcolor/upload'
          },
          thumbnails: {
              placeholders: {
                waitingPath: '/deepcolor/static/file-uploader/placeholders/waiting-generic.png',
                notAvailablePath: '/deepcolor/static/file-uploader/placeholders/not_available-generic.png'
              }
          },
          validation: {
              allowedExtensions: ['jpeg', 'jpg', 'png']
          },
          callbacks: {
            onComplete: function(id, name, response) {
              var serverPathToFile = response.filePath,
                  fileItem = this.getItemByFileId(id);
              console.log(id)
              console.log(name)
              console.log(response)
              if (response.success) {
                // hide original image
                var o_img = qq(fileItem).getByClass("qq-thumbnail-selector")[0];
                qq(o_img).addClass("hide");

                // show grayscale / colorized image
                var g_img = qq(fileItem).getByClass("qq-gray-selector")[0];
                g_img.setAttribute("src", response.img_grayscale);
                qq(g_img).addClass("hide");

                var r_img = qq(fileItem).getByClass("qq-result-selector")[0];
                r_img.setAttribute("src", response.img_result);

                // buttons
                qq(fileItem).getByClass("qq-thumbnail-wrapper")[0].setAttribute("qquuid", response.qquuid);
                qq(fileItem).getByClass("qq-thumbnail-wrapper")[0].setAttribute("onclick", "start_edit('" + id.toString() + "', '" + response.qquuid + "')");
              }
            }
          }
      });

      function start_edit(id, qquuid) {
        var fileItem = galleryUploader.getItemByFileId(id);
        var g_img = qq(fileItem).getByClass("qq-gray-selector")[0].getAttribute("src");
        $('img#edit_gray_img').attr('src', g_img);
        var r_img = qq(fileItem).getByClass("qq-result-selector")[0].getAttribute("src");
        $('img#edit_result_img').attr('src', r_img);

        $('div.circle').remove();

        _id = id;
        _qquuid = qquuid;
      }

      function upload_hints() {
        var xyrgb = [];
        $.each($('div.circle'), function(key, value) {
          var vv = $(value);
          var rx = parseInt(vv.attr('rx'));
          var ry = parseInt(vv.attr('ry'));
          var r = parseInt(vv.attr('r'));
          var g = parseInt(vv.attr('g'));
          var b = parseInt(vv.attr('b'));
          xyrgb.push([rx, ry, r, g, b]);
        })

        var hints = JSON.stringify(xyrgb);

        $.ajax({
          url: '/deepcolor/colorize',
          type: 'POST',
          data: {
            hints: hints,
            qquuid: _qquuid
          },
          success: function(data) {
            if (data.success) {
              var fileItem = galleryUploader.getItemByFileId(_id);
              var r_img = qq(fileItem).getByClass("qq-result-selector")[0];
              r_img.setAttribute("src", data.img_result);
              $('img#edit_result_img').attr('src', data.img_result);
            }
          }
        })
      }
  </script>

</html>
