# frozen_string_literal: true

require_relative './parser.rb'
require_relative './file_handler'
# require_relative './player_scraper'
require 'json'

class TeamScraper < Parser
  TEAM_STAT_TYPE = %i[
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
  ].freeze
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
    # PlayerScraper.new(@league).clubs_url
  end
end

url4 = 'https://fbref.com/en/comps/9/Premier-League-Stats'
# url5 = 'https://fbref.com/en/comps/12/La-Liga-Stats'
# url = './lib/test.html'
# url7 = 'https://fbref.com/en/squads/822bd0ba/Liverpool-Stats'
TeamScraper.new(url4, 'PL')
