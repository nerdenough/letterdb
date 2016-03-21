path = require 'path'
http = require 'http'
express = require 'express'
bodyParser = require 'body-parser'
cookieParser = require 'cookie-parser'
logger = require 'morgan'

config = require '../config'
index = require './routes/index'
explore = require './routes/explore'

app = express()
server = http.createServer(app)

# View engine setup
app.set 'views', path.join(__dirname, '../views')
app.set 'view engine', 'jade'

app.use logger 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: false
app.use cookieParser()
app.use express.static path.join(__dirname, '../public')

# Global route
app.use (req, res, next) ->
  req.config = config
  next()

# Define routes
app.use '/', index
app.use '/explore', explore

# Catch 404 errors
# Forwarded to the error handlers
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# Development error handler
# Displays stacktrace to the user
if app.get('env') is 'development'
  app.use (err, req, res, next) ->
    console.log err
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: err

# Production error handler
# Does not display stacktrace to the user
app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error',
    message: err.message
    error: ''

server.listen config.port
module.exports = app
