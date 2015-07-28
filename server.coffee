# download express 'npm install -g express'
# To start server: in the command line type 'node server.js'
# To use: In the browser go to https://localhost:80 or http://localhost:8000

# server basics
express = require 'express'
https = require 'https'
http = require 'http'
fs = require 'fs'

# summarize
summarize = require 'summarize'
superagent = require 'superagent'


options =
	key: fs.readFileSync './server/key.key'
	cert: fs.readFileSync './server/crt.crt'

app = express()

http.createServer(app).listen(8000)
https.createServer(options, app).listen(80)

app.use express.static __dirname

# app.get '/test', (req, res)->
# 	res.send 'Hello World!'
# 	return

# # console.log "SDF"

# # # app.get '/summarize', (req, res) ->
# # superagent.get('http://kotaku.com/an-album-a-minecraft-style-game-both-1625202335').end (err, res) ->
# # 	console.log summarize res.text

# ig = require('instagram-node').instagram({})

# ig.use
# 	access_token: '2072221807.1677ed0.cfc898e6c7124300bb90d836f3e14e9d'
# 	client_id: 'f41df43206564056b252ae8a5cb4019e'
# 	client_secret: 'c8cf2a15187c4aad8c1064e8f5e29736'

# user_id = '11830955'


# options =
# 	# count: '-1'
# 	min_timestamp: '1437284803'
# 	# min_id:  '1036718569272832486_11830955'
# 	# max_timestamp
# 	# max_id


# paginate = (err, result, pagination, remaining, limit)->
# 	console.log result[0]
# 	# console.log result.length
# 	# console.log remaining
# 	# console.log limit
# 	# console.log result[0]
# 	# console.log result[1]
# 	# console.log result[3]
# 	# if pagination.next
# 		# console.log result.length
# 		# pagination.next paginate


# ig.user_media_recent user_id, options, paginate


# # ig.user user_id, (err, result, remaining, limit)->
# # 	console.log err
# # 	console.log result
# # 	console.log remaining
# # 	console.log limit


# # ig.media_popular (err, medias, remaining, limit)->
# # 	console.log err
# # 	console.log medias
# # 	console.log remaining
# # 	console.log limit



# save screen shot
# make collage
