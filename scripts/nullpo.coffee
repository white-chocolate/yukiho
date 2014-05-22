# Description:
#   Yukiho bangs NullPointerException. 
#
# Commands:
#   ぬるぽ/ヌルポ - Replies "ｶﾞｯ".

module.exports = (robot) ->
  robot.hear /(ぬるぽ|ヌルポ)/i, (msg) ->
    msg.send "ｶﾞｯ"

