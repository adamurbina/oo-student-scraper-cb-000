require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    card = doc.css(".student-card")
    student_array = []
    card.each { |student|
        new_hash = {}
        new_hash[:name] = student.css(".student-name").text
        new_hash[:location] = student.css(".student-location").text
        new_hash[:student_url] = student.css("a").attribute("href").value

        student_array << new_hash
    }
    student_array
  end

  def self.scrape_profile_page(profile_url)

  end

end

#Scraper.scrape_index_page("./fixtures/student-site/index.html")
