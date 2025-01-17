# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri.HTML(html)

  projects = {}

  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {
      image_link: project.css('div.project-thumbnail a img').attribute('src').value,
      description: project.css('p.bbcard_blurb').text.strip,
      location: project.css('span.location-name').text,
      percent_funded: project.css('ul.project-stats li.first.funded strong').text.gsub("%","").to_i
    }
  end
  
  projects
  #binding.pry  
end

create_project_hash

# projects: kickstarter.css("li.project.grid_4")
# title = kickstarter.css('li.project.grid_4').css('h2.bbcard_name strong a').text
# image = kickstarter.css('li.project.grid_4').css('div.project-thumbnail a img').attribute('src').value
# desc = kickstarter.css('li.project.grid_4').css('p.bbcard_blurb').text.strip
# location = kickstarter.css('li.project.grid_4').css('span.location-name').text
# funded% = kickstarter.css('li.project.grid_4').css('ul.project-stats li.first.funded strong').text.gsub("%","").to_i