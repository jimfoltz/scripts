# nth.rb: print the nth line of input.

if ARGV.delete("-h") || ARGV.delete("--help")
  puts "nth: print the nth line of input."
  puts "Example:"
  puts "\tls | nth [N] [-e]"
  puts "\tN\tthe index of the line to print."
  puts "\t-e\texpand path, if file."
  exit
end

n = ARGV.shift

opt_e = ARGV.delete("-e")

n = n.to_i
n -= 1 if n > 0

res = ARGF.to_a[n].strip
if opt_e
  res = File.expand_path(res)
end

print res
