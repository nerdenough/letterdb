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

# GET: /letter/upload
router.get '/upload', (req, res) ->
  res.render 'letter/upload',
    title: req.config.title

# POST: /letter/download
router.post '/download', (req, res) ->
  title = req.body.title
  console.log title

  res.setHeader 'Content-disposition', 'attachment; filename=download.xml'
  res.setHeader 'Content-type', 'application/xml'

  res.send req.body.xml

module.exports = router
