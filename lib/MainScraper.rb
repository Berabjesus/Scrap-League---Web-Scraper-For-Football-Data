require 'nokogiri'
require 'open-uri'
require 'json'

class MainScraper
  def initialize(url, league)
    @url = url
    @league = league
    @team_hash = {}
    @stat_type = %i[
      name
      Matches_Played
      Win
      Draw
      Lost
      GF
      GA
      GDiff
      points
      XG
      XGA
      XGDiff
      XGDiff_90
      url
    ]
    parse_url
  end

  private

  def parse_url
    @parsed_url = Nokogiri::HTML(URI.open(@url))
    @table_rows = @parsed_url.at('tbody').css('tr')
    @table_rows.length.times do |i|
      @team_hash[@table_rows[i].css('td')[0].text] = {}
      (@stat_type.length - 1).times do |j|
        @team_hash[@table_rows[i].css('td')[0].text].merge!(@stat_type[j] => @table_rows[i].css('td')[j].text)
      end
      @team_hash[@table_rows[i].css('td')[0].text].merge!(@stat_type[-1] => @table_rows[i].css('td')[0].css('a').first['href'])
    end
    @team_hash = @team_hash.sort_by { |club_name, _attrib| club_name }.to_h
    teams_to_json
  end

  def teams_to_json
    File.write("./docs/#{@league}.json", JSON.dump(@team_hash))
  end
end

url4 = 'https://fbref.com/en/comps/9/Premier-League-Stats'
new_file = MainScraper.new(url4, 'Premier League')
