# frozen_string_literal: true
require_relative './constants.rb'
require_relative './parser.rb'
require_relative './file_handler'

class TeamScraper < Parser
  def initialize(url, league)
    @url = url
    @league = league
    @team_hash = {}
    parse_teams
  end

  private

  def parse_teams
    parsed_url = parse
    table_rows = parsed_url.at('tbody').css('tr')
    table_rows.length.times do |i|
      @team_hash[table_rows[i].css('td')[0].text.strip] = {}
      (TEAM_STAT_TYPE.length - 1).times do |j|
        @team_hash[table_rows[i].css('td')[0].text.strip].merge!(TEAM_STAT_TYPE[j] => table_rows[i].css('td')[j].text)
      end
      @team_hash[table_rows[i].css('td')[0].text.strip].merge!(TEAM_STAT_TYPE[-1] => table_rows[i].css('td')[0].css('a').first['href'])
    end
    @team_hash = @team_hash.sort_by { |club_name, _attrib| club_name }.to_h
    FileHandler.new(@team_hash, @league).teams_to_json
  end
end

# Spain_La_Liga =  'https://fbref.com/en/comps/13/3243/2019-2020-Ligue-1-Stats'
# TeamScraper.new(Spain_La_Liga, 'La Liga')
