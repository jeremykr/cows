// Generated by CoffeeScript 2.1.1
(function() {
  this.GraphicsApp = class GraphicsApp {
    constructor(canvas) {
      var addEvent;
      this.draw = this.draw.bind(this);
      this.update = this.update.bind(this);
      this.run = this.run.bind(this);
      this.canvas = canvas;
      this.gl = this.canvas.getContext("webgl");
      this.events = [];
      this.red = 0;
      this.green = 1;
      this.fps = 60;
      if (!this.gl) {
        alert("Unable to initialize WebGL. Your browser or machine may not support it.");
        return;
      } else {
        console.log("WebGL successfully initialized.");
      }
      addEvent = (event) => {
        return this.events.push(event);
      };
      document.addEventListener("keydown", addEvent);
    }

    draw() {
      var gl;
      gl = this.gl;
      gl.clearColor(this.red, this.green, 0, 1);
      return gl.clear(gl.COLOR_BUFFER_BIT);
    }

    update() {
      this.red += 0.01;
      if (this.red > 1) {
        this.red = 0;
      }
      this.green -= 0.01;
      if (this.green < 0) {
        return this.green = 1;
      }
    }

    // Returns `false` when the escape key is pressed.
    processEvent(e) {
      if (e instanceof KeyboardEvent && e.key === "Escape") {
        return false;
      }
      return true;
    }

    run() {
      if ((this.processEvent(this.events.pop())) === false) {
        return;
      }
      this.draw();
      this.update();
      return window.setTimeout(this.run, 1000 / this.fps);
    }

  };

}).call(this);
