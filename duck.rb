require "uri"

terms = URI.encode_www_form "q" => ARGV.join(" ")
cmd = "start \"\" https://duckduckgo.com/?#{terms}"
`#{cmd}`
