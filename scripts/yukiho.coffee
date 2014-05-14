module.exports = (robot) ->
  robot.here /yukiho/i, (msg) ->
    msg.send "呼んだ？"
