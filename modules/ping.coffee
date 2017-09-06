exports.run = (client, message, args) ->

  message.channel.send 'Pinging...' # Send the first message
    .then (msg) ->
      msg.edit "Pong! Took #{msg.createdTimestamp - message.createdTimestamp}ms" # Edit the message
    .catch (e) ->
      console.error e #Catch the errors if there are
exports.help = {
  name: 'ping'
}
