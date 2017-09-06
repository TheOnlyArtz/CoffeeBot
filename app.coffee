# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')

# Command loaders.

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
