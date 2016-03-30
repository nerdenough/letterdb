express = require 'express'
xmler = require 'node-xmler'

router = express.Router()

# GET: /upload
router.get '/', (req, res) ->
  res.render 'upload/upload',
    title: req.config.title

# POST: /upload
router.post '/', (req, res) ->
  client = req.baseXClient
  xml = req.body.xml
  author = req.body.author.replace ' ', ''
  category = req.body.category.replace ' ', ''

  element = new xmler.Element 'add', xml
  element.addAttribute
    key: 'path'
    value: '/letterdb/path/to/test.xml'

  command =
    text: 'ADD path="/letterdb/path/tp/test.xml" "' + xml + '"'

  client.command command, (res) ->
    console.log res

  res.render 'upload/upload',
    title: req.config.title
    success: true

# Exports the router
module.exports = router
