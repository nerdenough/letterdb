express = require 'express'
cheerio = require 'cheerio'

router = express.Router()

# GET: /explore
#
# Handles any request to the explore page including basic, logic and xquery
# search. Results are also calculated for pagination purposes.
router.get '/', (req, res) ->
  client = req.baseXClient
  q = req.query.q || ''

  parseSearch q

  if q.indexOf('XQ ') is 0
    xquerySearch client, q.substr(3), (results) ->
      results = results || ''
      raw = results
      results = results.split '\n'

      data = processResults(results)
      page = parseInt(req.query.page) || 1

      res.render 'explore/index',
        title: req.config.title
        results: data.slice(page * 8 - 8, page * 8)
        raw: raw
        total: data.length
        pages: Math.ceil(data.length / 8)
        page: page
        pagination: [page - 1, page, page + 1]
        query: q

  else
    basicSearch client, q, (results) ->
      results = results || ''
      raw = results
      results = results.split '\n'

      data = processResults(results)
      page = parseInt(req.query.page) || 1

      res.render 'explore/index',
        title: req.config.title
        results: data.slice(page * 8 - 8, page * 8)
        raw: raw
        total: data.length
        pages: Math.ceil(data.length / 8)
        page: page
        pagination: [page - 1, page, page + 1]
        query: q

parseSearch = (str) ->
  if str.indexOf('XQ ') is 0
    return str

  else
    str = str.split(/\b(?:AND|OR|NOT)\b/)
    console.log str

# Sends a query to BaseX requesting any files where the title element contains
# the specified string.
basicSearch = (client, str, callback) ->
  query =
    text:
      'declare default element namespace "http://www.tei-c.org/ns/1.0"; ' +
      'for $i in //title[contains(lower-case(text()), ' +
      'lower-case("' + str + '"))] ' +
      'return db:path($i)'

  client.query query, callback

xquerySearch = (client, str, callback) ->
  console.log str
  query =
    text:
      'declare default element namespace "http://www.tei-c.org/ns/1.0"; ' + str

  client.query query, callback

# Processes the results by converting the filenames to objects containing
# the file title, author and category, returning an array of all the converted
# data.
#
# Note: This data matches the file structure and folder names of the database,
# not the title or authors of the document as specified in the XML itself.
processResults = (results) ->
  data = []
  for result in results
    result = result.split '/'
    if result.length is 3
      data.push
        author: result[0]
        category: result[1]
        title: result[2].substr(0, result[2].length - 4)
  return data


# Export the router
module.exports = router
