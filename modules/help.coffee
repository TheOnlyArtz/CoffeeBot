Discord = (require 'discord.js')
exports.run = (client, message, args) ->

    cmdNames = client.commands.keyArray()
    textArr = []
    for command in cmdNames
      object = client.commands.get(command)
      textArr.push("**-#{object.help.name}** -> #{object.help.description}")

    message.channel.send(new Discord.RichEmbed().setDescription(textArr.join '\n').setColor(0x25aa7))
exports.help = {
  name: 'help',
  aliases : ['h']
  description : 'This command?'
}
