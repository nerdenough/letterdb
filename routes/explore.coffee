express = require 'express'
cheerio = require 'cheerio'
xmler = require 'node-xmler'

router = express.Router()

# GET: /explore/*?
router.get '/', (req, res) ->
  client = req.baseXClient

  client.command text: 'LIST ' + req.config.basex.database, (results) ->
    data = []
    results = results.split '\n'
    for result in results
      result = result.substr 0, result.indexOf(' ')
      result = result.split '/'
      console.log result
      if result.length is 3
        obj =
          author: result[0]
          category: result[1]
          title: result[2].substr(0, result[2].length - 4)
        data.push obj

    page = parseInt(req.query.page) || 1

    res.render 'explore/index',
      title: req.config.title
      results: data.slice(page - 1, page + 7)
      total: data.length * 8
      pages: data.length - 7
      page: page
      pagination: [page - 1, page, page + 1]
      query: req.query.q

# GET: /explore/search
#router.get '/search', (req, res) ->
#  client = req.baseXClient
#
#  query =
#    text:
#      'declare namespace tei="http://www.tei-c.org/ns/1.0"; ' +
#      '//tei:title[contains(text(), "' + req.query.q + '")]/../..'
#
#  client.query query, (results) ->
#    # TODO: Convert XML to JS object
#    res.render 'explore/search',
#      title: req.config.title
#      query: req.query.q
#      results: results

module.exports = router
