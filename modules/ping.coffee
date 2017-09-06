exports.run = (client, message, args) ->

  message.channel.send 'Pinging...'
    .then (msg) ->
      msg.edit("Pong! Took #{msg.createdTimestamp - message.createdTimestamp}ms")

exports.help = {
  name: 'ping'
}
