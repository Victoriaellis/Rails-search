# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
Article.destroy_all



url = 'https://newsapi.org/v2/everything?q=apple&from=2021-07-05&sortBy=popularity&apiKey=e14b5d5db07c4a3a9dccd8d865071112'
news_serialized = URI.open(url).read
news = JSON.parse(news_serialized)
news_list = news["articles"]
# puts movie_list



news_list.each do |news|
  url = news["url"]
  html_file = URI.open(url).read
  html_doc = Nokogiri::HTML(html_file)
  body = html_doc.search('h1').text + "," + html_doc.search('h2').text + "," + html_doc.search('h3').text

  html_doc.search('article').each do |element|
    # puts element.text.strip
    wpm = 225
    words = element.text.split(/\s+/).length
    @time = words / wpm
  end
   Article.create!(title: news["title"], body: body, url: news["url"], reading_time: @time.to_s)
   puts "created!"
end



