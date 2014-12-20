module.exports = (app)->
  # On all routes, allow any origin to hit the API.
  app.all '*', (req, res, next)->
    res.set 'Access-Control-Allow-Origin', '*'
    res.set 'Access-Control-Allow-Headers', 'Content-Type'
    next()
