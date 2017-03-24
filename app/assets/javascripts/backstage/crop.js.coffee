jQuery ->
  new LogoCropper()

class LogoCropper
  constructor: ->
    $("#cropbox").Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $("#company_crop_x").val(coords.x)
    $("#company_crop_y").val(coords.y)
    $("#company_crop_w").val(coords.w)
    $("#company_crop_h").val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $("#preview").css
      width: Math.round(100/coords.w * $("#cropbox").width()) + 'px'
      height: Math.round(100/coords.h * $("#cropbox").height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'

jQuery ->
  new CoverCropper()

class CoverCropper
  constructor: ->
    $("#article_cropbox").Jcrop
      aspectRatio: 740/350
      setSelect: [0, 0, 740, 350]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $("#article_crop_x").val(coords.x)
    $("#article_crop_y").val(coords.y)
    $("#article_crop_w").val(coords.w)
    $("#article_crop_h").val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $("#article_preview").css
      width: Math.round(100/coords.w * $("#article_cropbox").width() *(740/350)) + 'px'
      height: Math.round(100/coords.h * $("#article_cropbox").height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
