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
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}
    social_media = doc.css('.social-icon-container').css('a/@href')
    social_media.each do |profile|
      if profile.text.include?('twitter')
        profile_hash[:twitter] = profile.text
      elsif profile.text.include?('linkedin')
        profile_hash[:linkedin] = profile.text
      elsif profile.text.include?('github')
        profile_hash[:github] = profile.text
      else
        profile_hash[:blog] = profile.text
      end
    end
    profile_hash[:profile_quote] = doc.css('.profile-quote').text.strip
    profile_hash[:bio] = doc.css('.description-holder').css('p').text.strip
    profile_hash
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
# Twitter: doc.css('.social-icon-container').css('a/@href').text
# Linkedin: ""
# GitHub: ""
# Blog: ""
# Profile Quote: doc.css('.vitals-text-container').css('.profile-quote').text.strip
# Bio: doc.css('.description-holder').css('p').text.strip