require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    scraped_students = []
    info = Nokogiri::HTML(open(index_url))
 
    info.css(".student-card").each do |student_card|
      name = student_card.css(".card-text-container h4.student-name").text
      location = student_card.css(".card-text-container p.student-location").text
      url = student_card.css("a").attribute("href").value
      scraped_students << {name: name, location: location, profile_url: url}
    end
    scraped_students
  end
  
  
  def self.scrape_profile_page(profile_url)
    student_info = {}
    
    page = Nokogiri::HTML(open(profile_url))
   
    student_info[:profile_quote] = page.css(".main-wrapper.profile .vitals-container .vitals-text-container .profile-quote").text
    student_info[:bio] = page.css(".details-container .bio-block.details-block p").text
    
    #iterates through social media links and adds any to hash
    #if student doesn't have a link to that platform, the key does not exist in student's hash
    page.css(".social-icon-container a").each do |all_social_media|
      all_social_media.each do |social_media|
        if social_media[1].include?("twitter")
          student_info[:twitter] = social_media[1]
        elsif social_media[1].include?("linkedin")
          student_info[:linkedin] = social_media[1]
        elsif social_media[1].include?("github")
          student_info[:github] = social_media[1]
        else
          student_info[:blog] = social_media[1]
        end
      end
    end
    student_info
  end
  

end

