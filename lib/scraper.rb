require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# studentName =doc.css("h4.student-name").text
# doc.css("div.student-card")[0].css("h4.student-name").text
# doc.css("div.student-card")[0].css("p.student-location").text