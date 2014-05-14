# Description:
#   Yukiho stir up if a member in chat is tired.
#
# Commands:
# {つらい, つらくない, つかれた, アニメ見たい, わろた, ひでえ, etc} - hubot give you a love.
module.exports = (robot) ->
  robot.hear /つらい/, (msg) ->
    msg.send "っていうかさ。。音ノ木坂、なくなっちゃうんでしょ。みんな言ってるよ。そんな学校受けてもしょうがないって・・・だから進捗がんばって！"

  robot.hear /つらくない/, (msg) ->
    msg.send "頑固なんだからぁ。。。世間はもっと目新しくて、キラキラして、インパクトがあって、こう、ドキドキする進捗を求めているのよっ！！"

  robot.hear /つかれた/, (msg) ->
    msg.send "だってさ、はっきり言って進捗ある東工大生と進捗ない東工大生どっちがモテると思う？"

  robot.hear /アニメ見たい/, (msg) ->
    msg.send "やだ。お姉ちゃん何言ってんの！？"

  robot.hear /進捗あり/, (msg) ->
    msg.send "しーんちょーく、ひゃーくぱーせんとっ♪･･･っ！うぅ～私が何歌ってたっていいでしょっ///"

  robot.hear /わろた|ﾜﾛﾀ|ワロタ/, (msg) ->
    msg.send "何がおかしいのか言ってみろ"

  robot.hear /ひで(え|ぇ|w)|ひど(w|い)/, (msg) ->
    msg.send "ピンポンピンポーン♪正解です"