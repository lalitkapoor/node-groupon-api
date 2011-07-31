rest = require 'restler'
qs = require 'querystring'

format = 'json'

exports = module.exports = (key)->
	return new Groupon key, format

class Groupon
	constructor: (@key, @format)->
		@base = 'http://api.groupon.com/v2/'
		
	_call: (path, query, callback)->
		url = [@base, path, '.', @format, '?client_id=', @key, '&', query].join('')
		console.log url
		rest.get(url).on 'complete', (data)->
			callback data
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