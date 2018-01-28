class @GraphicsApp
    constructor: (@canvas) ->
        @gl = @canvas.getContext "webgl"
        @events = []
        @red = 0
        @green = 1
        @fps = 60

        if not @gl
            alert "Unable to initialize WebGL. Your browser or machine may not support it."
            return
        else
            console.log "WebGL successfully initialized."

        addEvent = (event) => @events.push event
        document.addEventListener "keydown", addEvent

    draw: =>
        gl = @gl
        gl.clearColor @red,@green,0,1
        gl.clear gl.COLOR_BUFFER_BIT

    update: =>
        @red += 0.01
        @red = 0 if @red > 1
        @green -= 0.01
        @green = 1 if @green < 0

    # Returns `false` when the escape key is pressed.
    processEvent: (e) ->
        if e instanceof KeyboardEvent and e.key == "Escape"
            return false
        return true

    run: =>
        return if (@processEvent @events.pop()) == false
        @draw()
        @update()
        window.setTimeout @run, 1000/@fps