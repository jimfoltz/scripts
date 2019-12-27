require "fileutils"
require 'uri'
require "net/http"
#require 'nokogiri'

opt_d = ARGV.delete("-d")

BIN_DIR = "C:/Users/Jim/bin"
BLEND_DIR = "C:/Users/Jim/Apps/blender/alpha"

url = "https://builder.blender.org/download/"
uri = URI.parse url

if opt_d
  if File.exist? "page.html"
    puts "Loading page.html"
    page = File.read "page.html"
  else
    puts "Fetching page..."
    page = Net::HTTP.get_response uri
    page = page.body
    puts "Saving page.html"
    File.open("page.html", "w") {|f| f.write(page)}
  end
else
  puts "Fetching page..."
  page = Net::HTTP.get_response uri
  page = page.body
end

downloads = page.scan(/blender-.+?-windows64\.zip/)
puts "blenders in page: #{downloads.inspect}" if opt_d
download = downloads.last

unless File.directory? BLEND_DIR
  FileUtils.mkdir_p BLEND_DIR
end

Dir.chdir BLEND_DIR

unless File.exist? download
  puts "Downloading #{download} ..."
  `curl -o #{download} #{url}#{download}`
else
  puts "Already downloaded #{download}"
end

base_dir = File.basename(download, ".zip")
unless File.directory? base_dir
  puts "unzipping..."
  `unzip #{download}`
else
  puts "Aleady unzipped."
end

blend_cmd = "#{BIN_DIR}/blender-alpha.cmd"
puts "Writing cmd file: #{blend_cmd}"
Dir.chdir ".."
cmd = "start \"\"  \"#{BLEND_DIR}/#{base_dir}/blender.exe\" %*"
puts cmd
File.open(blend_cmd, "w") {|f| f.write cmd}

