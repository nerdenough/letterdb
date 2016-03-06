express = require 'express'
router = express.Router()

# Explore
router.get '/', (req, res) ->
  res.render 'explore/explore', (
    title: req.config.title
    query: req.query.q
  )

module.exports = router
