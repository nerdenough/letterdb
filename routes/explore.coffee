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

  if q.indexOf('XQ ') is 0
    xquerySearch client, q.substr(3), (results) ->
      render req, res, results

  else if q.indexOf('LOGIC ') is 0
    logicSearch client, q.substr(6), (results) ->
      render req, res, results

  else
    basicSearch client, q, (results) ->
      render req, res, results

# Renders the explore page.
render = (req, res, results) ->
  results = results || ''
  raw = results
  results = results.split '\n'
  results = removeDuplicates(results)

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
    query: req.query.q

# Removes duplicates from an array and returns a distinct array.
removeDuplicates = (results) ->
  distinct = []
  match = false

  for result in results
    match = false

    for i in [0 .. distinct.length]
      if distinct[i] is result
        match = true

    if !match
      distinct.push result

  return distinct

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

# Sends a logic query to BaseX requesting any files matching the specified
# criteria.
logicSearch = (client, str, callback) ->
  query =
    text:
      'declare default element namespace "http://www.tei-c.org/ns/1.0"; ' +
      'for $i in //.[. contains text ' + str + '] ' +
      'return db:path($i)'

  client.query query, callback

# Sends an xquery strng to BaseX, sending any response from the database to the
# specified callback.
xquerySearch = (client, str, callback) ->
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
