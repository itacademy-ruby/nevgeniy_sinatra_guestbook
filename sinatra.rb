# encoding: utf-8

require 'sinatra'

get '/hi' do 
	"Privet"
end

get '/' do
  @posts = read_posts

  erb :index
end

post '/' do #=> Вывод будет на туже страницу, возможно выводить и так "/add_post"
	#Получаем автора и контент через params
	author = params[:author]
	content = params[:content]
	write_post author, content
	erb :index
end

# def read_posts
#   content = File.open("posts.txt") do |file|
#     file.read
#   end
# 	rows = content.split('====================').map{ |r| r.chomp }

# 	rows.each do |file|
# 		date = file.match /^date:\s(\S+)/
# 		author = file.match /^author:\s(\S+)/
# 		content = file.match /^content:\s(\S+)/
# 	end

# 	parsed_content ||= {} #массив в хэши
# 	parsed_content[:date] => date
# 	parsed_content[:author] => author
# 	parsed_content[:content] => content

# 	render_post = parsed_content
# 	render_post.each |file| do
#       puts file
# 	end

def read_posts 
  content = File.open("posts.txt") do |file| 
    file.read 
  end
 
  rows = content.split('====================').map{ |r| r.chomp }
  
  parsed_file ||= []
 
  rows.each do |file| 
    parsed_row = Hash.new #массив в хэши
 
    parsed_row[:date] => file.match(/^date:\s(\S+)/)
    parsed_row[:author] => file.match(/^author:\s(\S+)/)  
    parsed_row[:content] => file.match(/^content:\s(\S+)/) 

    parsed_file << parsed_row
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