# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')
prefix = "-"
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
  args = message.content.split ' '.slice 1
  command = message.content.split prefix

  cmd = client.commands.get command[1]
  console.log cmd, command[1]
  if cmd
    try
      cmd.run client, message, args
      console.debug "#{message.author.username} has just been exec #{cmd.help.name}"
    catch error
      throw error

client.login config.token
