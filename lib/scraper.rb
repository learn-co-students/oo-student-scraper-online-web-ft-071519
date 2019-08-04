require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css(".student-card")
    students.each do |student|
      student_hash = {}
      student_hash[:name] = student.css(".student-name").text
      student_hash[:location] = student.css(".student-location").text
      student_hash[:profile_url] = student.css("a").first["href"]
      student_array << student_hash
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    hash = {}
    hash[:twitter] = doc.css(".social-icon-container a")[0]["href"] if doc.css(".social-icon-container a")[0]
    hash[:linkedin] = doc.css(".social-icon-container a")[1]["href"] if doc.css(".social-icon-container a")[1]
    hash[:github] = doc.css(".social-icon-container a")[2]["href"] if doc.css(".social-icon-container a")[2]
    hash[:blog] = doc.css(".social-icon-container a")[3]["href"] if doc.css(".social-icon-container a")[3]
    hash[:profile_quote] = doc.css(".profile-quote").text
    # hash[:bio] = doc.css(".description-holder").text
    hash[:bio] = doc.css(".description-holder p").text.gsub(/\s+/, ' ').strip
    hash
    # binding.pry
  end

end

