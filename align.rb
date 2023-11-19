#!/usr/bin/ruby

# align.rb
#   A super simple align lines on a character.
#   Intended to be used from vim. For example,
#   to align 5 lines starting at the cursor you
#   would type in vim:
#     5!!align<Enter>
#
#  Can specify a different character as only parameter.
#     5!!align .<Enter>
#  Only splits on first occurance.
#  No other options.

PATTERN = '='

c = (ARGV.shift || PATTERN).chomp

lines = []
pos = 0

# Find max column to align on
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
    ary = line.split(c, 2) # 2 splits max
    print "%s %s %s\n" % [ary[0].ljust(pos), c, ary[1].strip]
}
