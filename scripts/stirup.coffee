# Description:
#   Yukiho stir up a quarrel if a meber in chat is tired.
#
# Commands:
# {つらい, つらくない, つかれた, アニメ見たい, わろた, ひでえ} - hubot give you a love.

message = undefined

module.exports = (robot) ->
  robot.hear //, (msg) ->
    message = msg

  robot.hear /つらい/, (msg) ->
    msg.send "かわいそうですね。でも進捗どうですか？"

  robot.hear /つらくない/, (msg) ->
    msg.send "それはよかった。なら、進捗どうですか？"

  robot.hear /つかれた/, (msg) ->
    msg.send "それはお疲れ様ですね。で、進捗どうですか？"

  robot.hear /アニメ見たい/, (msg) ->
    msg.send "それは叶わない願いですね。進捗を出してから人間らしいことを言ってください。"

  robot.hear /わろた|ﾜﾛﾀ|ワロタ/, (msg) ->
    msg.send "別に面白くないんですよ。早く進捗を出してください。"

  robot.hear /ひで(え|ぇ|w)|ひど(w|い)/, (msg) ->
    msg.send "ありがとうございます。進捗・・・今日は許してあげますよ。"
#  robot.hear /tired/i, (msg) ->
#    msg.send "That’s too bad. By the way, do you have no progress?. lol"
