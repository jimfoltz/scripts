

now = Time.now


def draw_month(mon = nil, year = nil, offset = 0)
  now = Time.now

  col_width = 3
  columns = 7
  width = columns * col_width

  mon = now.month if mon.nil?
  year = now.year unless year

  month_name = now.strftime('%B')
  year

  puts "#{month_name} #{year}".center(width)
  puts "Su Mo Tu We Th Fr Sa"


  day = 1
  date = Time.new(year, mon, day)
  pos = date.wday
  print " " * (col_width * pos )
  while date.mon == mon
    day = date.day
    print "[32m" if day == now.day
    print day.to_s.rjust(2), " "
    print "[0m" if day == now.day
    date += 1 * 24 * 60 * 60
    pos += 1
    puts if pos % 7 == 0
  end
end


draw_month
puts
