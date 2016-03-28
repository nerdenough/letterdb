express = require 'express'
cheerio = require 'cheerio'

router = express.Router()

# GET: /letter/:author/:category/:title
router.get '/*?', (req, res) ->
  client = req.baseXClient

  unless req.params[0]
    res.redirect '/explore'

  req.params[0] = req.config.basex.database + '/' + req.params[0] + '.xml'
  query =
    text: 'doc("' + req.params[0] + '")'

  client.query query, (letter) ->
    $ = cheerio.load letter
    console.log $('title').text()

module.exports = router
