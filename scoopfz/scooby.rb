require 'json'

def main
  db = "#{File.expand_path(File.dirname(__FILE__))}/app-list"
  update(db)# unless File.exist?(db)
end

def update db
  puts "Updating scoopfz database..."
  root = "C:/Users/Jim/scoop/buckets"

  buckets = `scoop bucket list`
  buckets = buckets.split("\n")
  result = `scoop list`
  installed = []
  result.split("\n").each { |line|
    next unless line.start_with?("  ")
    app, *rest = line.split
    installed << app
  }

  delim = " \| "

  apps = {}
  lines = ""
  buckets.each { |bucket|
    bdir = "#{root}/#{bucket}"
    if Dir.exist? "#{bdir}/bucket"
      json_dir = "#{bdir}/bucket"
    else
      json_dir = bdir
    end
    Dir.glob("#{json_dir}/*.json").each {|a|
      app_name = File.basename(a, ".json")
      json = JSON.load File.read(a)
      if installed.member?(app_name)
        lines << "*" << delim
      else 
        lines << " " << delim
      end
      lines << bucket.ljust(8)
      lines << delim << app_name.ljust(25)
      lines << delim << json["description"].to_s
      lines << delim << json["homepage"].to_s
      lines << "\n"
    }
  }

  File.open(db, "w") {|f| f.puts lines}
end

main()
