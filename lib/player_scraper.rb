require_relative './parser.rb'
require_relative './file_handler.rb'

class PlayerScraper < Parser
  PLAYER_STAT_TYPE = %i[
    Nation
    Poition
    Age
    Matches_Played
    Starts
    Minutes
    Goals
    Assists
    PK
    PK_Attempt
    Yellow_card
    Red_card
    Goals_per_90mins
    Assist_per_90mins
    G_plus_A_per_90mins
  ].freeze

  SITE = 'https://fbref.com'.freeze
  CLUB = 'CLUBS'.freeze
  def initialize(league)
    @league = league
    @url_hash = {}
    add_clubs_url
  end

  def add_clubs_url
    team_json_file = FileHandler.file_reader(CLUB, @league)
    team_json_file.each do |club, attrib|
      @url_hash.merge!(club => SITE + attrib['url'])
    end
    parse_players
  end

  def parse_players
    @url_hash.each do |team_name, url|
      @url = url
      parsed_url = parse
      scrap_players(parsed_url, team_name)
    end
  end

  def scrap_players(parsed_url, team_name)
    table_rows = parsed_url.at('tbody').css('tr')
    players_outter_hash = {}
    players_outter_hash[team_name] = {}
    players_inner_hash = {}
    table_rows.length.times do |i|
      players_inner_hash[table_rows[i].css('th').text.strip] = {}
      PLAYER_STAT_TYPE.length.times do |j|
        players_inner_hash[table_rows[i].css('th').text.strip].merge!(PLAYER_STAT_TYPE[j] => table_rows[i].css('td')[j].text.gsub(/[[:lower:]]+/, '').strip)
      end
      players_outter_hash[team_name].merge!(players_inner_hash)
    end
    FileHandler.new(players_outter_hash, @league).players_to_json
  end
end

PlayerScraper.new('PL')
