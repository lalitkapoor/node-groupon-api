http = require 'http'
rest = require 'restler'
qs = require 'querystring'

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
    rest.get(url).on 'complete', (error, data)->
      callback error, data
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