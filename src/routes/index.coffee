express = require 'express'
router = express.Router()

# Homepage
router.get '/', (req, res) ->
  res.render 'index', (
    title: req.config.title
  )

module.exports = router
