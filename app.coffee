# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')

# Command loaders.
client.commands = new Discord.Collection()

fs.readdir './modules', (err, files) ->
  throw err if err

  jsFiles = (f for f in files when f.split '.'.pop == 'js')
  console.log jsFiles

  for i, f in jsFiles
    try
      props = (require "./modules/#{i}")
      console.log "#{f + 1} Loaded #{i}"
      client.commands.set props.help.name , props
    catch error
      throw error

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
