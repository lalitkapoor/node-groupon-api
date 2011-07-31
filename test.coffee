groupon = require('./groupon')('YOUR_KEY_HERE')

getDeals = (division)->
	groupon.getDeals {'division_id': division}, (data)->
		console.log '----------'
		console.log '----------'
		console.log division
		console.log '----------'
		for deal in data.deals
			console.log deal.title

groupon.getDivisions {}, (data)->
	for division in data.divisions
		try
	  		getDeals division.id
		catch error
			console.log error
			node.exit(1)