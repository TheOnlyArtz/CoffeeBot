# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')
artzlogger = (require 'artzlogger')
client.logger = new artzlogger
prefix = "-"
# Command loaders.
client.commands = new Discord.Collection()

fs.readdir './modules', (err, files) ->
  throw err if err

  jsFiles = (f for f in files when f.split '.'.pop == 'js')

  for i, f in jsFiles
    try
      props = (require "./modules/#{i}")
      client.logger.info "#{f + 1} Loaded #{i}"
      client.commands.set props.help.name , props
    catch error
      throw error

client.on "ready", () ->
  client.logger.info('I\'m ready')

@event
client.on "message", (message) ->
  args = message.content.split ' '.slice 1
  command = message.content.split prefix

  return if command[0].charAt 0 != prefix
  cmd = client.commands.get command[1]
  if cmd
    try
      cmd.run client, message, args
      console.debug "#{message.author.username} has just been exec #{cmd.help.name}"
    catch error
      throw error

client.login config.token
