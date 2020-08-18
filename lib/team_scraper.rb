require_relative './parser.rb'
require_relative './file_writer'
require 'nokogiri'
require 'open-uri'
require 'json'

class TeamScraper < Parser
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
    parsed_url = parse
    table_rows = parsed_url.at('tbody').css('tr')
    table_rows.length.times do |i|
      @team_hash[table_rows[i].css('td')[0].text] = {}
      (@stat_type.length - 1).times do |j|
        @team_hash[table_rows[i].css('td')[0].text].merge!(@stat_type[j] => table_rows[i].css('td')[j].text)
      end
      @team_hash[table_rows[i].css('td')[0].text].merge!(@stat_type[-1] => table_rows[i].css('td')[0].css('a').first['href'])
    end
    @team_hash = @team_hash.sort_by { |club_name, _attrib| club_name }.to_h
    FileWriter.new(@team_hash, @league).teams_to_json
  end
end

url4 = 'https://fbref.com/en/comps/9/Premier-League-Stats'
url5 ='https://fbref.com/en/comps/12/La-Liga-Stats'
url = './lib/test.html'
url7 ='https://fbref.com/en/squads/822bd0ba/Liverpool-Stats'
TeamScraper.new(url4, 'PL')
