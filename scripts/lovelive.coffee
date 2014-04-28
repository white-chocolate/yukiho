# Description:
#   A way to get information about lovelive.
#
# Commands:
#   ダレカタスケテー - Replies "チョットマッテテー".
#   hubot next lovelive - Getting next lovelive's broadcastsing date using Animemap API.

module.exports = (robot) ->
  robot.hear /ダレカタスケテー/i, (msg) ->
    msg.send "チョットマッテテー"

  robot.respond /next lovelive/i, (msg) ->
    animeMap msg, "ラブライブ", (item) ->
      if item?
        d = new Date
        if getDayStr(d) != item.week || getTimeStr(d) >= item.time
          d.setTime(d.getTime() + (7 - d.getDay()) * 86400 * 1000)
        msg.send "#{item.title}の第#{item.next}は#{d.getDate()}日（#{item.week}）、" +
          "#{item.station}で#{item.time}に放送だよ!!"
      else
        msg.send "なかったよ..."

getDayStr = (d) ->
  week = [ "日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日", ]
  week[d.getDay()]

getTimeStr = (d) ->
  hours = ("0" + d.getHours().toString()).slice(-2)
  minutes = ("0" + d.getMinutes().toString()).slice(-2)
  "#{hours}:#{minutes}"

animeMap = (msg, query, cb) ->
  msg.http('http://animemap.net/api/table/tokyo.json')
    .get() (err, res, body) ->
      res = JSON.parse(body)
      res = res.response?.item
      if res?.length > 0
        for item in res
          if item.title.indexOf(query) != -1
            cb item
            return
      cb undefined
