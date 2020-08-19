# frozen_string_literal: true

require_relative './parser.rb'
require_relative './file_handler.rb'

class PlayerScraper < Parser
  PLAYER_ATT_ATTRIB = %i[
    Nation
    Position
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
  PLAYER_DEF_ATTRIB = %i[
    Tackles
    Tackles_won
    Blocks
    Interceptions
    Int_&_blks
    Clearances
    Errors
  ].freeze
  PLAYER_DEF_SELECTED_INDEX = [4, 5, 19, 23, 24, 25, 26].freeze
  PLAYER_GK_ATTRIB = %i[
    Goals_conceded
    Goals_conceded_90
    Saves
    Save_%
    Clean_sheet
  ].freeze
  PLAYER_GK_SELECTED_INDEX = [6, 7, 9, 10, 14].freeze
  SITE = 'https://fbref.com'
  DIR_TYPE = 'CLUBS'

  def initialize(league)
    @league = league
    @url_hash = {}
    add_clubs_url
  end

  private

  def add_clubs_url
    team_json_file = FileHandler.file_reader(DIR_TYPE, @league)
    team_json_file.each do |club, attrib|
      @url_hash.merge!(club => SITE + attrib['url'])
    end
    parse_players
  end

  def parse_players
    @url_hash.each do |team_name, url|
      @url = url
      parsed_url = parse
      parsed_url.xpath('//comment()').each { |comment| comment.replace(comment.text) }
      scrap_players(parsed_url, team_name)
    end
  end

  def scrap_players(parsed_url, team_name)
    table_rows_attack = parsed_url.at('tbody').css('tr')
    table_rows_defence = parsed_url.css('tbody')[8].css('tr')
    table_rows_gk = parsed_url.css('tbody')[2].css('tr')
    players_outter_hash = {}
    players_outter_hash[team_name] = {}
    players_inner_hash = {}
    table_rows_attack.length.times do |i|
      inner_hash = players_inner_hash[table_rows_attack[i].css('th').text.strip] = {}
      PLAYER_ATT_ATTRIB.length.times do |j|
        inner_hash.merge!(PLAYER_ATT_ATTRIB[j] => text_cleaner(table_rows_attack[i].css('td')[j].text))
      end
      if !table_rows_defence[i].nil? && (table_rows_attack[i].css('th').text.strip == table_rows_defence[i].css('th').text.strip)
        PLAYER_DEF_SELECTED_INDEX.each_with_index do |k, l|
          inner_hash.merge!(PLAYER_DEF_ATTRIB[l] => table_rows_defence[i].css('td')[k].text)
        end
      end
      table_rows_gk.length.times do |m|
        next unless table_rows_attack[i].css('th').text.strip == table_rows_gk[m].css('th').text.strip

        PLAYER_GK_SELECTED_INDEX.each_with_index do |k, l|
          inner_hash.merge!(PLAYER_GK_ATTRIB[l] => table_rows_gk[m].css('td')[k].text)
        end
      end
      players_outter_hash[team_name].merge!(players_inner_hash)
    end
    FileHandler.new(players_outter_hash, "#{@league}_Players").players_to_json
  end

  def text_cleaner(string)
    string.gsub(/[[:lower:]]+/, '').strip
  end
end

PlayerScraper.new('PL')
