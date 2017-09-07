CoffeeScript = (require 'coffeescript')
exports.run = (client, message, args) ->
  codes = args
  try
    
      final = CoffeeScript.compile(codes, { bare: 'on' }).replace('.then(e', ',').replace('})))', '}))')
      message.channel.send "Compiling `#{codes}` to javascript..." # Send the first message
        .then (msg) ->
          delay = () -> setTimeout msg.edit(final, code : 'js'), 1000
          delay()
        .catch (e) ->

  catch error
      console.error error

exports.help = {
  name: 'coffee2js',
  aliases : ['c2js']
  description : 'Compile coffeescript to javascript.'

}
