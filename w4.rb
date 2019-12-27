require "net/http"
require "uri"
require 'json'

url = "https://api.weather.gov/gridpoints/CLE/94,45/forecast"

data = JSON.parse Net::HTTP.get(URI.parse(url))

data["properties"]["periods"].each {|per|
  print "#{per["name"].ljust(20, ".")}"
  print "#{per["temperature"]}"
  print " #{per["shortForecast"]}"
  puts
}
