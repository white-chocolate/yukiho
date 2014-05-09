# Description:
#   Yukiho tells us about lovelive.
#
# Commands:
#   ダレカタスケテー - Replies "チョットマッテテー".
#   hubot next lovelive - Getting next airdate of lovelive using Animemap API.
#   [At 18:00 everyday] - Informs us if today is an air date of lovelive.

cron = require('cron').CronJob
message = undefined

module.exports = (robot) ->
  robot.hear //, (msg) ->
    message = msg

  robot.hear /ダレカタスケテー/i, (msg) ->
    msg.send "チョットマッテテー"

  robot.respond /next lovelive/i, (msg) ->
    d = new Date
    getNextLovelive robot, d, (item) ->
      if item?
        msg.send "#{item.title}#{item.next}は#{item.date}の#{item.time}から#{item.station}で放送だよぉ♪"
      else
        msg.send "お姉ちゃん、見つからないよぉ..."

  new cron
    cronTime: "0 0 18 * * *"
    timeZone: "Asia/Tokyo"
    start: true
    onTick: ->
      d = new Date
      getNextLovelive robot, d, (item) ->
        # console.log(d, item)
        if item? && item.date == getDateStr(d) && message?
          message.send "#{item.title}#{item.next}は今日の#{item.time}からだよっ。もう録画予約した？"

getNextLovelive = (robot, d, cb) ->
  animeMap robot, "ラブライブ", (item) ->
    if item?
      if getDayStr(d) != item.week || getTimeStr(d) >= item.time
        # create new instance
        d = new Date(d.getTime() + (7 - d.getDay()) * 86400 * 1000)
      item.date = getDateStr d
      cb item
    else
      cb undefined

animeMap = (robot, query, cb) ->
  robot.http('http://animemap.net/api/table/tokyo.json')
    .get() (err, res, body) ->
      res = JSON.parse body
      res = res.response?.item
      if res?.length > 0
        for item in res
          if item.title.indexOf(query) != -1
            cb item
            return
      cb undefined

getDayStr = (d) ->
  week = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
  week[d.getDay()]

getDateStr = (d) ->
  month = ("0" + (d.getMonth() + 1).toString()).slice(-2)
  date = ("0" + d.getDate().toString()).slice(-2)
  "#{month}/#{date}"

getTimeStr = (d) ->
  hours = ("0" + d.getHours().toString()).slice(-2)
  minutes = ("0" + d.getMinutes().toString()).slice(-2)
  "#{hours}:#{minutes}"
