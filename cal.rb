require 'date'

def draw_cal(mon = nil, year = nil, offset = 0)

  now = Time.now

  col_width = 3
  columns = 7
  width = columns * col_width

  mon = now.month if mon.nil?
  year = now.year unless year
  year = Integer(year)

  date = Time.new(year, mon, now.day)
  month_name = date.strftime('%B')

  puts "#{month_name} #{year}".center(width)
  puts "Su Mo Tu We Th Fr Sa"

  day = 1
  date = Date.new(year, mon, day)
  pos = date.wday
  print " " * (col_width * pos)
  while date.month == mon
    day = date.day
    print "[32m" if day == now.day && now.mon == date.mon
    print day.to_s.rjust(2), " "
    print "[0m" if day == now.day
    date += 1
    pos += 1
    puts if pos % 7 == 0
  end
end

if month = ARGV.shift
  month = Integer(month)
end
if year = ARGV.shift
  year = Integer(year)
end

draw_cal(month, year)
puts
