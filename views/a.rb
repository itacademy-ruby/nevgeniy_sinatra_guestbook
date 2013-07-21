require 'date'
 
rows = [ "date: 2013-07-18 21:40:28 +0400\nname: Vasya\ncontent: Testovoe soobshenie", 
         "date: 2013-07-18 21:40:33 +0400\nname: Vasya\ncontent: Testovoe soobshenie", 
         "date: 2013-07-18 21:43:28 +0400\nname: Vasya Brovkin\ncontent: OLOLOLOLOLOLO", 
         "date: 2013-07-18 21:43:28 +0400\nname: Vasya Brovkin\ncontent: OLOLOLOLOLOLO", 
         "date: 2013-07-18 21:43:28 +0400\nname: Vasya Brovkin\ncontent: OLOLOLOLOLOLO", 
         "date: 2013-07-20 14:25:00 +0400\nname: OLOLO\ncontent: ", 
         "date: 2013-07-20 14:25:06 +0400\nname: OLOLO\ncontent: ", 
         "date: 2013-07-20 14:26:29 +0400\nname: OLOLO\ncontent: "]
 
entries = rows.collect do |row|
  if /^date: (?<date>.*)\nname: (?<name>.*)\ncontent: (?<content>.*)$/m =~ row
    { date: DateTime.parse(date), name: name, content: content }
  else
    raise 'Invalid guestbook entry'
  end
end
 
entries.each do |entry|
  puts "date is #{entry[:date]}, name is #{entry[:name]}, content is #{entry[:content].inspect}"
end