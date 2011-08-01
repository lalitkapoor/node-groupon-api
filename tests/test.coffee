colors = require 'colors'
pool = require('poolr').createPool 2

groupon = require('../lib/groupon').client 'YOUR_KEY_HERE'

failed = []

pool.on 'idle', ()->
  if failed.length > 0
    console.log JSON.stringify(failed).red
    return
  console.log JSON.stringify(failed).green
  return

getDeals = (division, attempt, callback)->
  groupon.getDeals {'division_id': division}, (error, data)->
    console.log "----------"
    console.log division
    console.log "----------"
    
    #retry upto 3 times
    if error?
      console.error 'error parsing json data in deals for division: '.red + division + ' attempt: ' + (attempt+1)
      if attempt>=2 #if we tried 3 times, then there is something wrong, notify user
        failed.push division
        console.error 'FAILED parsing json data in deals for division: '.red + division + ' attempt: ' + (attempt+1)
        return callback(error, null)
      else
        return getDeals division, attempt+1, callback #retry, up to 3 attempts

    return callback(null, data)

groupon.getDivisions {}, (error, data)->
  if error?
    console.log 'error parsing json data in divisions'.red
    return
  for division in data.divisions
    pool.addTask getDeals, division.id, 0, (error, data)->
      if !error?
        for deal in data.deals
          console.log deal.title
  return
  
  #getDeals 'chicago', 0