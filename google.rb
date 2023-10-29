
terms = ARGV.join("+")

cmd = "start \"\" https://www.google.com/search?q=#{terms}"

`#{cmd}`

