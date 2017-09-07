CoffeeScript = require('coffeescript')
{ exec } = (require 'child_process')
exports.run = (client, message, args) ->
  codes = args
  final = CoffeeScript.compile(codes, { bare: 'on' }).replace('.then(e', ',').replace('})))', '}))')
  try
    theEval = eval(CoffeeScript.compile(codes, { bare: 'on' })
    .replace('.then(e', ',')
    .replace('})))', '}))'))
    message.channel.send "Input:\`\`\`coffee\n#{codes}\`\`\`\nOutput:\`\`\`coffee\n#{theEval.toString().replace(/object promise/i, '<Promise Pending>')}\n\`\`\`"
  catch error
    message.channel.send "\`\`\`error\n#{error.toString()}\n\`\`\`"

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
