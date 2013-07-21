# encoding: utf-8

require 'sinatra'
require 'date'
require 'bootstrap'
# require 'sinatra/assetpack'

get '/hi' do
"Privet"
end

get '/' do
  @posts = read_posts
  erb :index
end

get '/clear' do
  clear
  redirect to '/'
end

post '/' do #=> Вывод будет на туже страницу, возможно выводить и так "/add_post"
#Получаем автора и контент через params
author = params[:author]
content = params[:content]
if author != nil && author.empty? != true && 
    content != nil && content.empty? != true
    write_post author, content
end

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
      raise "Ошибка данных"
    end
  end

  if entries.size > 0 
  entries.each do |entry|
    str << "<strong>Дата:</strong> #{entry[:date]}<br /> <strong>Имя:</strong> #{entry[:name]}<br /> 
      <strong>Сообщение:</strong> <blockquote>#{entry[:content]}</blockquote><br />"
  end
  else 
    str << "<strong><blockquote>Гостевая книга пуста :(</strong></blockquote>"
  end
    str.gsub("\r\n", "<br />")
    str
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

def clear
  File.open('posts.txt', 'w') do |file| 
    file.print ''
  end
end