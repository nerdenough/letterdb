express = require 'express'
xmler = require 'node-xmler'
router = express.Router()

# GET: /explore
router.get '/', (req, res) ->
  res.render 'explore/index',
    title: req.config.title

# GET: /explore/search
router.get '/search', (req, res) ->
  # TODO: Get data from BaseX database

  res.render 'explore/search',
    title: req.config.title
    query: req.query.q

module.exports = router
