require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    hash = {}
    scraped_students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.student-card").each do|student|
    
        hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attr("href").value,
        }
        
        scraped_students << hash
    end
    return scraped_students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_contacts = {}
    
    doc.css("div.social-icon-container")[0].css("a").each do |contact|
     student_contacts [:twitter]= contact.attr("href") if contact.attr("href").include?"twitter"
     student_contacts [:linkedin]= contact.attr("href") if contact.attr("href").include?"linkedin"
     student_contacts [:github]= contact.attr("href") if contact.attr("href").include?"github"
     student_contacts [:blog]= contact.attr("href") if contact.attr("href").include?"http:"    
    
    end
    
  #   student_contacts [:twitter]= 
  #       doc.css("div.social-icon-container")[0].css("a")[0].attr("href") if doc.css("div.social-icon-container")[0].css("a")[0] != nil

  #   student_contacts[:linkedin] = 
  #   doc.css("div.social-icon-container")[0].css("a")[1].attr("href") if doc.css("div.social-icon-container")[0].css("a")[1] != nil

  # student_contacts[:github] = 
  #     doc.css("div.social-icon-container")[0].css("a")[2].attr("href") if doc.css("div.social-icon-container")[0].css("a")[2] != nil 

  # student_contacts[:blog] = 
  #     doc.css("div.social-icon-container")[0].css("a")[3].attr("href") if doc.css("div.social-icon-container")[0].css("a")[3] != nil
       
    student_contacts[:profile_quote] = 
       doc.css("div.profile-quote").text
       
     student_contacts[:bio] = doc.css("div.description-holder p").text
    
    
    return student_contacts 
  end

end

# studentName =doc.css("h4.student-name").text
# doc.css("div.student-card")[0].css("h4.student-name").text
# doc.css("div.student-card")[0].css("p.student-location").text
# url = doc.css("div.student-card")[0].css("a").attr("href").value


# twitter = doc.css("div.social-icon-container")[0].css("a")[0].attr("href")
#linkedin = doc.css("div.social-icon-container")[0].css("a")[1].attr("href")
#github = doc.css("div.social-icon-container")[0].css("a")[2].attr("href")
#blog = doc.css("div.social-icon-container")[0].css("a")[3].attr("href")
#profile quote = doc.css("div.profile-quote").text
#bio = doc.css("div.description-holder p").text
