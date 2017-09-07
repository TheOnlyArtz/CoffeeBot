# Ignore.
Discord = (require 'discord.js')
client = new Discord.Client()
config = (require './config.json')
fs = (require 'fs')
artzlogger = (require 'artzlogger')
client.logger = new artzlogger
prefix = "-"
# Command loaders.
client.commands = new Discord.Collection
client.aliases = new Discord.Collection
fs.readdir './modules', (err, files) ->
  throw err if err

  jsFiles = (f for f in files when f.split '.'.pop == 'js')

  for i, f in jsFiles
    try


      props = (require "./modules/#{i}")

      # Log the loading files.
      client.logger.info "#{f + 1} Loaded #{i}"

      #  Set the collections to the commands and aliases

      client.commands.set props.help.name , props

      for a in props.help.aliases
        client.aliases.set(a, props.help.name)

    catch error
      throw error

client.on "ready", () ->
  client.logger.info('I\'m ready')

client.on "message", (message) ->
  return if message.author.id != '208936898566160384'
  # return if command[0].charAt 0 != prefix
  try
    args = message.content.split(' ').slice(1).join(' ')
    command = message.content.split(prefix)[1].slice(' ').split(' ')[0]
    cmd = client.commands.get command
    cmd = client.commands.get(client.aliases.get command) if cmd == undefined
    if cmd
      try
        client.logger.debug "#{message.author.username} has just been exec #{cmd.help.name}"
        cmd.run(client, message, args)
      catch error
        throw error
  catch error



client.login config.token
