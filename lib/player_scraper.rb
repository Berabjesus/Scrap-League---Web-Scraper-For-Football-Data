# frozen_string_literal: true

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
    @file_name = "#{league} Players"
    @url_array = {}
    @players_outter_hash = {}
    @players_inner_hash = {}
    add_clubs_url
  end

  def add_clubs_url
    team_json_file = FileHandler.file_reader(CLUB, @league)
    team_json_file.each do |club, attrib|
      @url_array.merge!(club => SITE + attrib['url'])
    end
    parse_players
  end

  def parse_players
    @url = @url_array['Arsenal']
    parsed_url = parse
    table_rows = parsed_url.at('tbody').css('tr')
    # p table_rows[33].css('th').text.strip
    # p table_rows[33].css('td > a > span')[0].text.gsub(/[^[:upper:]]+/, '').strip
    @players_outter_hash[@url_array.first.first] = { @players_inner_hash => {} }
    table_rows.length.times do |i|
      # p table_rows[i].css('th').text.strip
      @players_inner_hash[table_rows[i].css('th').text.strip] = {}
      PLAYER_STAT_TYPE.length.times do |j|
        # print "-- #{table_rows[i].css('td')[i].text.gsub(/[[:lower:]]+/, '').strip} --"
        # table_rows[i].css('th').text.strip.merge!(PLAYER_STAT_TYPE[i] => table_rows[i].css('td')[i].text.gsub(/[[:lower:]]+/, '').strip) 
        @players_inner_hash[table_rows[i].css('th').text.strip].merge!( PLAYER_STAT_TYPE[j] => table_rows[i].css('td')[j].text.gsub(/[[:lower:]]+/, '').strip)
      end
      @players_outter_hash[@url_array.first.first].merge!(@players_inner_hash)
    end
    p @players_outter_hash
  end
end

PlayerScraper.new('PL')
