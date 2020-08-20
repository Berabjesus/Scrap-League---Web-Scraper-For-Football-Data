require 'terminal-table'
require_relative './constants.rb'
require_relative './team_scraper.rb'
require_relative './player_scraper.rb'
require_relative './file_handler.rb'

class InterfaceDataControl
  attr_accessor :league
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
  end

  private

  def call_team_scraper
    url = CLUB_WEBSITE[@league]
    TeamScraper.new(url, @league.to_s)
  end

  def call_player_scraper
    PlayerScraper.new(@league.to_s)
  end

  public

  def suggest_best_xi
    players = gets_player_hash
    att_hash = {}
    mid_hash = {}
    def_hash = {}
    gk_hash = {}
    players.each do |_club, player|
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
    best_attckers = [att_hash[0][0], att_hash[1][0]]
    best_midfielder = [mid_hash[0][0], mid_hash[1][0], mid_hash[2][0], mid_hash[3][0]]
    best_defenders = [def_hash[0][0], def_hash[1][0], def_hash[2][0], def_hash[3][0]]
    [best_attckers, best_midfielder, best_defenders, gk_hash[0]]
  end

  def gets_league_hash
    FileHandler.file_reader('CLUBS', @league.to_s)
  end

  def gets_team_hash
    teams = FileHandler.file_reader('PLAYERS', "#{PLAYERS_DIR}#{@league}_Players.json")
    teams.keys
  end

  def gets_player_hash(league = nil, _team = nil)
    if league.nil?
      FileHandler.file_reader('PLAYERS', "#{PLAYERS_DIR}#{@league}_Players.json")
    else
      players = FileHandler.file_reader('PLAYERS', "#{PLAYERS_DIR}#{league}_Players.json")
      teams = []
      players.values.length.times do |i|
        teams << players.values[i]
      end
      row1 = []
      row2 = []
      row3 = []
      teams.length.times do |i|
        teams[i].keys.length.times do |j|
          row1 << teams[i].keys[j]
          row1 << teams[i].values[j].values
          row1.flatten!
          row3 << row1
          row1 = []
        end
        row2 << row3
        row3 = []
      end
      row2
    end
  end
end
