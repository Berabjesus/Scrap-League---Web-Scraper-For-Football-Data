require_relative './file_handler.rb'
class PlayerScraper
  SITE = 'https://fbref.com'
  CLUB = 'CLUBS'
  def initialize(league)
    @league = league
    @file_name = "#{league} Players"
    @url_array = []
  end
  
  def clubs_url
    team_json_file = FileHandler.file_reader(CLUB, @league)
    p team_json_file.class
    # p team_json_file.select {|club, attrib| attrib["url"]}
    team_json_file.each do |club, value| 
      p club
      p value['url']
    end
    p @url_array
  end
end

PlayerScraper.new('PL').clubs_url
