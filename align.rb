#!/usr/bin/ruby

# align.rb
#   A super simple align lines on a character.
#   Intended to be used from vim for markdown tables.

CHAR = '='

c = (ARGV.shift || CHAR).chomp

lines = []

pos = 0

ARGF.each_with_index {|line, i|
	lines << line
	if line.index(c).to_i > pos
		pos = line.index(c)
	end
}

lines.each_with_index {|line, i|
	if line.index(c).nil?
		puts line.chomp
		next
	end
	ary = line.split(c)
	print "%s %s %s\n" % [ary[0].ljust(pos), c, ary[1].strip]
}
