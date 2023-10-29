#encoding: utf-8
def usage
  puts "p: path tool. find a command in your path"
  puts "Usage:"
  puts "  p [options] [<args>]"
  puts "  p\t\t\t list paths"
  puts "  p <cmd> \t\t locate a command in your path. exact match."
  puts "  p -s <pattern>\t search for a command. regexp."
  puts "  p -e <command>\t edit found command"
end

paths = ENV["PATH"].split(";").uniq {|elm| elm.downcase}

args = ARGV
opts = args.select {|e| e[0] == "-"}
args -= opts

if opts.include?("-h")
  usage
  exit
end

if opts.include?("-d")
  puts "opts: #{opts.inspect}"
  puts "args: #{args.inspect}"
  exit
end

arg = args.shift

if arg.nil?
  puts paths
  exit
end

builtins = []
h = `help`
h.split("\n").each {|line|
  match = line.match(/^([A-Z]+)\s/)
  builtins << match[1] if match
}
puts "built-in: #{arg}" if builtins.include?(arg.upcase)

macros = {}
macrofile = "C:/Users/Jim/Scripts/doskey/macros.txt"
File.readlines(macrofile).map {|line|
  macro, dfn = line.split("=")
  macros[macro] = dfn
}
if macros.keys.include?(arg.downcase)
  puts "doskey macro: #{arg} = #{macros[arg]}"
end

exts = ENV["PATHEXT"].split(";").map(&:downcase)
paths.unshift "."

def find_exact(paths, exts, cmd)
  found = []
  paths.each {|path|
    exts.each {|ext|
      file = "#{path}\\#{cmd}#{ext}"
      #puts "searching for #{file}"
      if File.exist?(file)
        found << file
      end
    }
  }
  found
end

if opts.empty?
  puts find_exact(paths, exts, arg)
  exit
end


if opts.include?("-s")
  ext_str = "*{" + exts.join(",") + "}"
  re = Regexp.new arg, true
  found = []
  paths.each {|path|
    targets = "#{path}/#{ext_str}".gsub('\\', '/')
    entries = Dir.glob(targets).map{|e| File.basename(e)}.grep(re)
    entries.each {|ent|
      puts "#{path}\\#{ent}"
      found << "#{path}\\#{ent}"
    }
  }
  #puts found
end


if opts.include?("-e")
  found = find_exact(paths, exts, arg)
  puts found
  #`gvim "#{found[0]}"`
  #`nvim-qt "#{found[0]}"`
  #pid = spawn %%nvim-qt "#{found[0]}"%
  editor = ENV.fetch('EDITOR', "notepad")
  pid = spawn %%#{editor} "#{found[0]}"%
  Process.detach pid
end

if opts.include?("-c")
  found = find_exact(paths, exts, arg)
  puts found
  #puts File.read "#{found[0]}"
  exec("bat -n #{found[0]}")
end

if opts.include?("-d")
  found = find_exact(paths, exts, arg)
  puts found
  #`start "" /b /d "#{File.dirname(found[0])}"`
`start "" /b /d "#{File.dirname(found[0])}"`
end
