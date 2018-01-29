Matrix = linearAlgebra().Matrix
Vector = linearAlgebra().Vector

class @Triangle
    constructor: (@gl) ->
        @pos = new Vector.zero(2)
        @scale = new Vector.zero(2)
        vData = [
            -1, -1, 0,
            1, -1, 0,
            0, 1, 0
        ]

        vShaderSource = 
            """
            attribute vec3 pos;
            void main() {
                gl_Position = vec4(pos, 1);
            }
            """

        fShaderSource =
            """
            precision mediump float;
            void main() {
                gl_FragColor = vec4(1,1,1,1);
            }
            """
        # Create and compile shaders
        gl = @gl
        vShader = gl.createShader gl.VERTEX_SHADER
        fShader = gl.createShader gl.FRAGMENT_SHADER
        gl.shaderSource vShader, vShaderSource
        gl.shaderSource fShader, fShaderSource
        gl.compileShader vShader
        gl.compileShader fShader
        console.log gl.getShaderInfoLog vShader
        console.log gl.getShaderInfoLog fShader
        @program = gl.createProgram()
        gl.attachShader @program, vShader
        gl.attachShader @program, fShader

        # Fill ArrayBuffer with vertex data
        buffer = new ArrayBuffer 4 * vData.length
        dv = new DataView buffer
        for i in [0..vData.length-1]
            dv.setFloat32 i*4, vData[i], true
            
        # Create and bind GL buffers
        vbo = gl.createBuffer()
        gl.bindBuffer gl.ARRAY_BUFFER, vbo
        gl.bufferData gl.ARRAY_BUFFER, buffer, gl.STATIC_DRAW
        gl.vertexAttribPointer 0, 3, gl.FLOAT, false, 0, 0
        gl.enableVertexAttribArray 0
        gl.bindAttribLocation @program, 0, 'pos'

        gl.linkProgram @program
        console.log gl.getProgramInfoLog @program

    draw: =>
        gl = @gl
        gl.useProgram @program
        gl.drawArrays gl.TRIANGLES, 0, 3