
terms = ARGV.join("+")

cmd = "start \"\" https://duckduckgo.com/?q=#{terms}"

`#{cmd}`
