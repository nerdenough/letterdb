gulp = require 'gulp'
coffee = require 'gulp-coffee'

# Compiles the CoffeeScript located in the src to JavaScript, placing the
# compiled files into the app folder.
gulp.task 'coffee', ->
  gulp
    .src './src/**/*.coffee'
    .pipe coffee bare: true
    .pipe gulp.dest './app/'

# Watches the CoffeeScript folder for changes, running the main coffee task
# when a change is detected.
gulp.task 'coffee:watch', ->
  gulp.watch './src/**/*.coffee', ['coffee']
