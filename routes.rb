require 'nokogiri'
require 'open-uri'
require 'sinatra'

configure :development do
  set :bind, '0.0.0.0'
  set :port, 3000
end


get '/' do
  erb :index
end

  
get '/images/:loller' do
  param = params[:loller].gsub("*", "//") + "/"
  root = "http://" + param
  page = Nokogiri::HTML(open(root)) #Pull page
  good_links = []
  
  puts "Found {page.css('img').count} images!"
#   puts page.css('img')[0].attributes
#   return page
  
  if page.css('img').count > 0
    
    page.css('img').each do |image| #loop images to find good ones
      good_links << image
    end
  
    puts good_links[0].attributes["src"]
    puts if good_links[0].attributes["src"].to_s.include? param
    
    
    if good_links[0].attributes["src"].to_s.include? param
      puts "Includes!"
      return "<img src='" + good_links[rand(good_links.count)].attributes["src"].to_s.gsub('///', '//') + "' />"
    else
      puts "Doens't include!"
      return "<img src='" + root + good_links[rand(good_links.count)].attributes["src"].to_s.gsub('///', '//') + "' />"
    end
    
  else 
    
    return "that's not cool."
    
  end
  
 
end



get '/squirrel' do
  root = "http://www.sugarbushsquirrel.com/"
  page = Nokogiri::HTML(open(root)) #Pull squirrels
  good_links = []
  
  page.css('img').each do |image| #loop through squirrels to find good squirrels
    if image.attributes["height"]
        good_links << image if image.attributes["height"].value.to_i > 200
      end
    end
  
  return "<img src='" + root + good_links[rand(good_links.count)].attributes["src"].to_s + "' />"
end





