# tg: termgraph. makes a graph from data on the command line
# >echo cats,12;dogs,10;birds,14 | tg --record-separator ;

require 'optparse'

options = {
  :width => 80,
  :rec_sep => "\n",
  :field_sep => ',',
  :color => true
}

if ENV['COLUMNS']
  options[:width] = Integer(ENV['COLUMNS'])
end

opt_parser = OptionParser.new do |opts|
  opts.on("-s [c]",  "Field separator defaults to comma") do |v|
    options[:field_sep] = v
  end
  opts.on("--record-separator [c]",  "Record Separator defaults to newline") do |v|
    options[:rec_sep] = v
  end
  opts.on("-h", "--help", "Help") do 
    puts opts
    exit
  end
  opts.on("", "--title [The Title]", "Title") do |v|
    options[:title] = v
  end
  opts.on("--[no-]color", "color on") do |v|
    options[:color] = v
  end
  opts.on("--ascii", "ascii on") do |v|
    options[:ascii] = v
  end
  opts.on("-cN", "--column=N", "Column") do |v|
    options[:col] = v.to_i
  end
  opts.on("--sort", "Sort") do |v|
    options[:sort] = v
  end
  opts.on("-r", "--reverse", "Reverse Sort") do |v|
    options[:rev] = v
  end
  opts.on("-wN", "--width=N", "Width") do |v|
    options[:width] = v.to_i
  end
end
opt_parser.parse!

reset = ""
blue = ""
green = ""
blue2 = ""
block = "■" # ctrl-k fS; alt-254

if options[:color]
  reset = "[0m"
  blue = "[34m"
  green = "[32m"
  blue2 = "[1m[34m"
  block = "■" # ctrl-k fS; alt-254
  #block = "\u2589"
  #block = "\u9724"
end

block = "*" if options[:ascii]

color = [blue, blue2]
labels = []
values = []
field_widths = []

# p ARGF.to_a

col = options[:col] ? options[:col] - 1 : 1
lines = ARGF.readlines(options[:rec_sep])

if options[:sort]
  if options[:rev]
    lines.sort_by!{|a| -a.split(options[:field_sep])[col].to_i}
  else
    lines.sort_by!{|a| a.split(options[:field_sep])[col].to_i}
  end

end
lines.each {|line|
#ARGF.each_line { |line|
  #p line
  next if line.start_with?("#")
  line.chomp!(options[:rec_sep])
  line.strip!
  if line && !line.empty?
    cols = line.split(options[:field_sep])
    labels << cols[0].strip
    values << (cols[col] ? cols[col].strip : "none")
  end
}

field_widths[0] = labels.map{|l| l.length}.max
#field_widths[1] = values.map{|l| l.length}.max

step =  values.max.to_f / (options[:width])
scale = (options[:width] - field_widths[0] - 14).to_f / values.map{|v|v.to_i}.max

labels.length.times { |i|
  cn = i % color.length
  blocks = Integer(values[i].to_f * scale) + 1
  printf "%#{field_widths[0]}s: " , labels[i]
  print color[cn]
  print block * blocks
  print reset
  puts " #{values[i]}"
}

