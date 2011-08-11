http = require 'http'
qs = require 'querystring'
wwwdude = require 'wwwdude'

rest = wwwdude.createClient({contentParser: wwwdude.parsers.json, gzip: true})

format = 'json'

exports = module.exports = {
  client: (key)->
    return new Client key, format
}

class Client
  constructor: (@key, @format)->
    @base = 'http://api.groupon.com/v2/'
    
  _call: (path, query, callback)->
    url = @base + path + '.' + @format + '?client_id=' + @key + '&' + query
    rest.get(url).on('success', (data, response)->
      callback null, data
    ).on('error', (err)->
      callback err
    )
    return
      
      
  getDivisions: (options, callback)->
    path = 'divisions'
    query = ''
    if options?
      query = qs.stringify options
    this._call(path, query, callback)
    
  getDeals: (options, callback)->
    path = 'deals'
    query = ''
    if options?
      query = qs.stringify options
    this._call(path, query, callback)