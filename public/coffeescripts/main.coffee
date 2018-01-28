setCanvasSize = () ->
    $canvas = $("#glCanvas")
    $canvas.attr "width", $(window).width() - 20
    $canvas.attr "height", $(window).height() - 20

#-----------------------

setCanvasSize()

canvas = document.querySelector "#glCanvas"
graphics = new @GraphicsApp canvas
graphics.run()
