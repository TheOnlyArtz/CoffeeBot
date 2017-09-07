CoffeeScript = require('coffeescript')
{ exec } = (require 'child_process')
# js2coffee = (require 'js2coffee')
exports.run = (client, message, args) ->
  codes = args
  final = CoffeeScript.compile(codes, { bare: 'on' }).replace('.then(e', ',').replace('})))', '}))')
  try
    theEval = cleanEval(codes, client, message, args)
    # code = js2coffee.build(codes).catch(e);
    message.channel.send "\`\`\`xl\n#{eval(final)}\n\`\`\`"
  catch error
    console.error error

exports.help = {
  name: 'eval',
  aliases : ['ev']
  description : 'Runs a snippet of code.'
}

inspect = require('util').inspect
cleanEval = (code, client, message, args) ->
  if typeof code != "string"
    code = inspect(code, {depth : 0})
  code = code
        .replace(/`/g, "`" + String.fromCharCode(8203))
        .replace(/@/g, "@" + String.fromCharCode(8203))
        .replace(client.token, "mfa.VkO_2G4Qv3T--NO--lWetW_tjND--TOKEN--QFTm6YGtzq9PH--4U--tG0");
