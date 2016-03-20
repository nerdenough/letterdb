express = require 'express'
xmler = require 'node-xmler'

router = express.Router()

# Search
router.get '/search', (req, res) ->
  if req.query.q
    # TODO: Build query and send to BaseX REST server
    query = new xmler.Element 'query'
    text = new xmler.Element 'text', req.query.q
    query.addElement text

  res.render 'search/results', (
    title: req.config.title
    query: req.query.q
  )

module.exports = router
