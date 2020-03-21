# find-su.rb - find and print SketchUp executables on Windows
#

QUOTE = ARGV.delete("-q")

def walk(path, depth, max_depth)
  begin
    children = Dir.children(path)
  rescue => e
    #warn e
    return
  end
  if children.include?("SketchUp.exe")
    print '"' if QUOTE
    print "#{path}"
    print '"' if QUOTE
    puts
  end
  children.each {|child|
    full = File.join(path, child)
    if File.directory?(full) && (depth < max_depth)
      walk(full, depth + 1, max_depth)
    end
  }
end

max = 3
walk("C:/Program Files (x86)/", 1, max)
walk("C:/Program Files/", 1, max)

