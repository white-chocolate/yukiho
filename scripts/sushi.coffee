# Description:
#   SUSHI
#
# Commands:
#   (sushi|鮨|すし|寿司|スシ|🍣) - Send a sushiyuki image.
#
# Author:
#   White Chocolate (inspired by Qiita)

module.exports = (robot) ->
  robot.hear /(sushi|鮨|すし|寿司|スシ|🍣)/i, (msg) ->
    url = randomSushiyukiUrl()
    msg.send url

randomSushiyukiUrl = () ->
  base = 'https://d1zd1v0cxnbx2w.cloudfront.net/images/sets/sushiyuki/'
  num = Math.ceil(Math.random() * 80) # 1..80
  filename = if num < 10 then "0#{num}.png" else "#{num}.png"
  base + filename
