require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open('https://learn-co-curriculum.github.io/student-scraper-test-page/index.html')
    doc = Nokogiri::HTML(html)
    students = []
   
     doc.css("div.student-card").each do |student|
      student_name = student.css("div.card-text-container h4.student-name").text
      student_url = student.css("a").attribute("href").value
      student_location = student.css("div.card-text-container p.student-location").text

      students << {name: "#{student_name}", location: "#{student_location}", profile_url: "#{student_url}"}
    
    end
    students
    
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    profile = {}

    page = doc.css("div.vitals-container").each  do |info|
      social_links = info.css("div.social-icon-container a").collect{|element| element['href'] }
      social_links.each do |link|
        if link.include?("twitter")
          profile[:twitter] = link
        elsif link.include?("linkedin")
          profile[:linkedin] = link
        elsif link.include?("github")
          profile[:github] = link
        else 
          profile[:blog] = link
        end
      end
      profile[:profile_quote] = info.css("div.vitals-text-container div.profile-quote").text
      profile[:bio] = doc.css("div.details-container div.bio-block.details-block div.bio-content.content-holder div.description-holder p").text
    end
    profile
  end
  
    
  end


#doc.css("div.details-container div.bio-block.details-block")
#social_and_bios.css("div.social-icon-container a").attribute("href").value => "https://twitter.com/jmburges"
#social_links = social_and_bios.css("a")
#   social_links.each {|link| puts link['href']} 
#     => https://twitter.com/jmburges https://www.linkedin.com/in/jmburges https://github.com/jmburges http://joemburgess.com/
