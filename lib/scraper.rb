require 'open-uri'
require 'nokogiri'
require 'pry'

require_relative './student.rb'

class Scraper
  

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    my_array = []
    doc.css(".student-card").each do |student|
      my_hash = {}
      my_hash[:name] = student.css("h4").text
      my_hash[:location] = student.css(".student-location").text 
      my_hash[:profile_url] = student.css("a").attr("href").value
      my_array << my_hash
    end
    my_array
  end
    

  def self.scrape_profile_page(profile_url)
     html = open(profile_url)
     doc = Nokogiri::HTML(html)
     links = doc.css(".social-icon-container a")
      media = {}
      
   links.each do |link| 
     #binding.pry
    if link.attr("href").include? "twitter"
      media[:twitter] = link.attr("href")
    elsif link.attr("href").include? "linkedin"
      media[:linkedin] = link.attr("href")
    elsif link.attr("href").include? "github"
      media[:github] = link.attr("href")
    else 
     media[:blog] = link.attr("href")
    end 
    media[:profile_quote] = doc.css('.profile-quote').text
    media[:bio] = doc.css('.description-holder p').text
    
  end 
  
    media
  end 
  
end 




 
