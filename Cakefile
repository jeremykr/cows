{exec} = require 'child_process'
task 'build', 'Build project from src/*.coffee to public/javascripts/*.js', ->
    exec 'coffee --compile --output public/javascripts public/coffeescripts', (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr
