# frozen_string_literal: true

require_relative './constants.rb'
require_relative './team_scraper.rb'
require_relative './player_scraper.rb'
require_relative './file_handler.rb'

class InterfaceDataControl
  def initialize; end

  def league_data_options(user_input)
    case user_input
    when 1
      @league = CLUB_WEBSITE.keys[user_input - 1]
    when 2
      @league = CLUB_WEBSITE.keys[user_input - 1]
    when 3
      @league = CLUB_WEBSITE.keys[user_input - 1]
    when 4
      @league = CLUB_WEBSITE.keys[user_input - 1]
    when 5
      @league = CLUB_WEBSITE.keys[user_input - 1]
    else
      return false
    end

    call_team_scraper
    call_player_scraper
    # suggest_best_xi(4, 4, 2)
  end

  private

  def call_team_scraper
    url = CLUB_WEBSITE[@league]
    TeamScraper.new(url, @league.to_s)
    # clear_screen
  end

  def call_player_scraper
    PlayerScraper.new(@league.to_s)
    # clear_screen
  end

  def suggest_best_xi(defn, mid, att)
    @players = gets_player_hash
    @players.values.class
    att_hash = {}
    mid_hash = {}
    def_hash = {}
    gk_hash = {}
    @players.each do |_club, player|
      player.each do |player_name, attrib|
        att_hash.merge!(player_name => attrib['Attacker_rating']) if attrib['Position'].include? 'FW'
        mid_hash.merge!(player_name => attrib['Assists']) if attrib['Position'].include? 'MF'
        def_hash.merge!(player_name => attrib['Defender_rating']) if attrib['Position'].include? 'DF'
        gk_hash.merge!(player_name => attrib['Goal_keeper_rating']) if attrib['Position'].include? 'GK'
      end
    end
    att_hash = att_hash.sort_by { |_key, value| value }.reverse!
    mid_hash = mid_hash.sort_by { |_key, value| value }.reverse!
    def_hash = def_hash.sort_by { |_key, value| value }.reverse!
    gk_hash = gk_hash.sort_by { |_key, value| value }.reverse!
  end

  def gets_league_hash
    @league = FileHandler.file_reader('CLUBS', @league.to_s)
  end

  def gets_player_hash
    @players = FileHandler.file_reader('PLAYERS', "#{PLAYERS_DIR}#{@league}_Players.json")
  end
end

# InterfaceDataControl.new.league_data_options(gets.chomp.to_i)
