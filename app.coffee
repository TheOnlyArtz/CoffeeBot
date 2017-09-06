# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')

# Command loaders.
client.commands = new Discord.Collection()

fs.readdir './modules', (err, files) ->
  throw err if err

  jsFiles = files.filter f => f.split '.'.pop() ===  'js'
  console.log jsFiles
client.on "ready", () ->
  console.log('I\'m ready')

@event
client.on "message", (message) ->
  if message.content == 'ping'
    try
      message.channel.send 'Pinging...'
        .then (e) =>
          e.edit "Ping! Took: #{e.createdTimestamp - message.createdTimestamp}ms"
    catch error
      console.log 'Error'
      throw error

client.login config.token
