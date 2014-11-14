# Dependencies:
#   "githubot": "0.4.x"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#
# Commands:
#   hubot deploy <repo>
#
# Author:
#   AtraeInc, white-chocolate
module.exports = (robot) ->
  require 'date-utils'
  github = require('githubot')(robot)

  url_api_base = "https://api.github.com"

  robot.respond /deploy\s+([-_\.0-9a-zA-Z]+)/i, (msg) ->
    github.handleErrors (res) ->
      msg.send "失敗しました〜...\nError: #{res.statusCode} #{res.error}\n#{res.body}"

    # FIXME: hard coding...
    repo = "white-chocolate/#{msg.match[1]}"
    base = "production"
    head = "master"

    date = new Date()
    release_time = date.toFormat("YYYY/MM/DD HH24:MI")
    pr_title = "[Release to #{base}] #{release_time}"

    data = { title: pr_title, head: head, base: base }
    github.post "#{url_api_base}/repos/#{repo}/pulls", data, (pr) ->
      github.get "#{url_api_base}/repos/#{repo}/pulls/#{pr.number}/commits", (commits) ->
        pr_body = ""
        for commit in commits
          unless commit.commit.message.match(/Merge pull request/)
            continue
          pr_body += "- [ ] #{commit.commit.message.replace(/\n\n/g, ' ').replace(/Merge pull request /, '')} by @#{commit.author.login}\n"
        pr_body = "以下のPRがリリースされます！\n" + pr_body if pr_body != ""
        pr_body += "\n計 #{commits.length} 個のコミットです！\n"

        update_data = { body: pr_body }
        github.patch "#{url_api_base}/repos/#{repo}/pulls/#{pr.number}", update_data, (updt_pr) ->
          msg.send "リリース用のプルリクエストを送りました！ (#{head} -> #{base})\n\t#{pr.html_url}\n\tMergeでデプロイ、Closeでキャンセルできるよっ\n#{commits.length} 個のコミットがリリースされます！"
