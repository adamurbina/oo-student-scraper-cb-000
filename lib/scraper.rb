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
      doc = Nokogiri::HTML(open(profile_url))
      new_hash = {}
      links = doc.css(".social-icon-container").css("a")
      links.each {|link|
          url = link.attribute("href").value
          case true
          when url.include?('twitter')
              new_hash[:twitter] = url
          when url.include?('linkedin')
              new_hash[:linkedin] = url
          when url.include?('github')
              new_hash[:github] = url
          when url.include?('http:')
              new_hash[:blog] = url
          end
      }
      new_hash[:profile_quote] = doc.css(".profile_quote").text
      quote = doc.css(".profile_quote").text


      new_hash[:bio] = doc.css(".description-holder").css("p").text

      puts profile_url

  end

end

Scraper.scrape_profile_page("./fixtures/student-site/students/ryan-johnson.html")
