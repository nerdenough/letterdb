express = require 'express'
xmler = require 'node-xmler'
router = express.Router()

# GET: /explore
router.get '/', (req, res) ->
  # TODO: Show latest letters
  res.render 'explore/index',
    title: req.config.title

# GET: /explore/search
router.get '/search', (req, res) ->
  client = req.baseXClient

  query =
    text:
      'declare namespace tei="http://www.tei-c.org/ns/1.0"; ' +
      '//tei:title[contains(text(), "' + req.query.q + '")]'

  client.query query, (results) ->
    # TODO: Convert XML to JS object
    res.render 'explore/search',
      title: req.config.title
      query: req.query.q
      results: results

module.exports = router
