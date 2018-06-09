require 'open-uri'
require 'pry'

class Scraper

  #scraping the index page that lists all of the students
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    students = []
    index_page.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile_link = "#{student.attr('href')}"
        student_location = student.css(".student-location").text
        student_name = student.css(".student-name").text
        students << {name: student_name, location: student_location, profile_url: student_profile_link}
        end
    end
    students
  end

  #scraping an individual student's profile page to get further information about that student.
  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    link =  profile_page.css(".social-icon-container").map do
      {|el| el.attribute('href').value}
    links.each do |link|
    if link.include?("linkedin")
      student[:linkedin] = link
    elsif link.include?("github")
      student[:github] = link
    elsif link.include?("twitter")
      student[:twitter] = link
    elsif link.include?("profile_quote")
      student[:profile_quote] = link
    elsif link.include?("bio")
      student[:bio] = link
    else
      student[:blog] = link
    end
    end
  end

end
