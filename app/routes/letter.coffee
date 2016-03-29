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

  client.query query, (data) ->
    $ = cheerio.load data
    letter =
      title: $('title').text()
      author: $('author').find('name').text()
      text: $('body').html()

    res.render 'letter/letter',
      title: req.config.title
      letter: letter
      raw: data

module.exports = router
