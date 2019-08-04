require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    student_array = []
    doc.css(".student-card").each do |student_card|
      student = {
          :name => student_card.css('a').css(".card-text-container").css('h4').text,
          :location => student_card.css('a').css(".card-text-container").css('p').text,
          :profile_url => student_card.css('a/@href').text
      }
      student_array << student
    end
    student_array
    # binding.pry
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

end

#Scrape Index
# Student name: doc.css(".student-card").first.css('a').css(".card-text-container").first.css('h4').text
# => "Ryan Johnson"
# Student location:  doc.css(".student-card").first.css('a').css(".card-text-container").css('p').text
# => "New York, NY"
# Student profile: doc.css(".student-card").first.css('@href').text
#
#
# Scrape Profile
# Twitter:
# Linkedin:
# GitHub:
# Blog:
# Profile Quote:
# Bio: