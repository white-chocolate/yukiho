# Description:
#  Yukiho speaks about prime numbers
#
# Commands:
#   [number] - When number is prime number, Yukiho talks us about prime numbers
#   素数 - Yukiho speaks about prime numbers

module.exports = (robot) ->
  robot.hear /-?\d{1,7}/i, (msg) ->
    #msg.send msg.match[0]
    num = Number(msg.match[0])
    if(testPrimality(num) == false)
      return

    r = Math.random()
    idx = Math.floor(r * 7)
    m = num + " is prime number!"
    if idx == 0
      m = num + "は素数だよー"
    else if idx == 1
      m = num + "は素数だと思うよぉ"
    else if idx == 2
      m = "おねーちゃんは、"+num+"が素数だって分かんなかったんだよ"
    else if idx == 3
      m = num + "は好きな素数だなー"
    else if idx == 4
      m = "ししっ、みんなは"+num+"が素数って分かったぁ？"
    else if idx == 5
      m = num + "が素数だって分かんないんじゃ、音ノ木坂には受からないよ！"
    else
      m = "あっ、" + num + "って素数だよねー"

    msg.send m

  robot.hear /素数/i, (msg) ->
    r = Math.random()
    idx = Math.floor(r * 3)
    m = "素数"
    maxNumber = 10000
    if idx == 0
      m = "素数って素敵だよねー"
    else if idx == 1
      m = "素数だいすき！"
    else
      primeNumbers = getPrimeNumbers(maxNumber)
      i = Math.floor(Math.random() * primeNumbers.length)
      if i >= primeNumbers.length then i = primeNumbers - 1
      pn = primeNumbers[i]
      m = "今の気分だと、おすすめの素数は" + pn + "かなぁ"

    msg.send m

getPrimeNumbers = (max) ->
  if max <= 1
    return []
  primeNumbers = []
  primeNumbers.push(2)
  for n in [2..max]
    isPrime = true
    for i in [0..primeNumbers.length]
      if (primeNumbers[i] * primeNumbers[i] > n)
        break
      if 0 == (n % primeNumbers[i])
        isPrime = false
        break
    if isPrime
      primeNumbers.push(n)

  return primeNumbers

testPrimality = (num) ->
  if num <= 1
    return false
  primeNumbers = getPrimeNumbers(num)
  return (primeNumbers[primeNumbers.length - 1] == num)
