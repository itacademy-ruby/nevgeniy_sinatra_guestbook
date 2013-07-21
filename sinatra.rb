# encoding: utf-8

require 'sinatra'
require 'date'

get '/hi' do
"Privet"
end

get '/' do
  @posts = read_posts
  # render_posts
  erb :index
end

post '/' do #=> Вывод будет на туже страницу, возможно выводить и так "/add_post"
#Получаем автора и контент через params
author = params[:author]
content = params[:content]
write_post author, content
erb :index
redirect to '/'
end


def read_posts
  str = ""
  content = File.open("posts.txt") do |file|
    file.read
  end

  rows = content.split("====================\n").map{ |r| r.chomp }

  entries = rows.collect do |row|
    if /^date: (?<date>.*)\nname: (?<name>.*)\ncontent: (?<content>.*)$/m =~ row
      { date: DateTime.parse(date), name: name, content: content }
    else
      raise 'Invalid guestbook entry'
    end
  end
  #  if entries.empty?
  #   empty_str << "Наша гостевая книга пуста :("
  # end
  entries.each do |entry|
    str << "<strong>Дата:</strong> #{entry[:date]}<br /> <strong>Имя:</strong> #{entry[:name]}<br /> <strong>Сообщение:</strong> #{entry[:content]}<br />"
  end
  if str.size == 0
    puts "В книге еще нет сообщений :("
  else
    str
  end
end

def write_post author, content
#создать текст для записи в файл
# запись в файл
  File.open('posts.txt', 'a') do |file|
    file.puts "date: #{Time.new}"
    file.puts "name: #{author}"
    file.puts "content: #{content}"
    file.puts "===================="
end
end