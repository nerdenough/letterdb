express = require 'express'
router = express.Router()

# Search
router.get '/search', (req, res) ->
  res.render 'search/results', (
    title: req.config.title
    query: req.query.q
  )

module.exports = router
