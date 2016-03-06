gulp = require 'gulp'
sass = require 'gulp-sass'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'

# Converts the Sass located in the sass folder to CSS, placing the converted
# files into the public CSS folder.
gulp.task 'sass', ->
  gulp
    .src './sass/**/*.scss'
    .pipe sourcemaps.init()
    .pipe sass().on 'error', sass.logError
    .pipe sourcemaps.write()
    .pipe gulp.dest './public/css/'

# Watches the Sass folder for changes, running the main sass task when a change
# is detected.
gulp.task 'sass:watch', ->
  gulp.watch ['./sass/**/*.scss'], ['sass']

# Compiles the CoffeeScript located in the src folder to JavaScript, placing the
# compiled files into the app folder.
gulp.task 'coffee', ->
  gulp
    .src './src/app/**/*.coffee'
    .pipe coffee bare: true
    .pipe gulp.dest './app/'

# Watches the CoffeeScript folder for changes, running the main coffee task
# when a change is detected.
gulp.task 'coffee:watch', ->
  gulp.watch ['./src/app/**/*.coffee'], ['coffee']
