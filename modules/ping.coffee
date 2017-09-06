exports.run = (client, message, args) ->

  message.channel.send 'Command handler works'

exports.help = {
  name: 'ping'
}
