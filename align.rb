#!/usr/bin/ruby

# align.rb
#   A super simple align lines on a character.
#   Intended to be used from vim for markdown tables.

c = (ARGV.shift || '=').chomp
w = []
lines = []

def dim(o)
  return
  print "[2m"
  p o
  print "[0m"
end

ARGF.each_with_index {|line, i|
  dim line
  ary = line.split(c).map(&:strip)
  lines[i] = ary
  ary.each_with_index {|e, j|
    w[j] ||= 0
    if w[j] < e.length
      w[j] = e.length
    end
  }
}
dim w
dim lines

a = []
lines = lines.each_with_index{|line, i|
  line = line.each_with_index.map {|l, j|
    #line[j] = l.ljust(w[j])
  }
}
dim lines

lines.each_with_index {|line, i|
  line.each_with_index {|e, j|
    if e.empty? && j == 0
      print "#{c} "
      next
    end
    if (j != w.length-1)
    print e
    print "#{c} ".rjust(w[j] - e.length + 3)
    next
    end
    if !e.empty?
      print e
    end
  }
  puts
}

