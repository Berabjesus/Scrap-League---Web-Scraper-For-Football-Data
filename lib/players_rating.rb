require_relative './constants.rb'
require_relative 'file_handler.rb'

class PlayersRating
  DIR_TYPE = 'PLAYERS'.freeze
  def initialize
    @players_file_array = FileHandler.access_all_players_files
    @file_name = nil
    filter_file_names
  end

  def filter_file_names
    @players_file_array.length.times do |i|
      @file_name = @players_file_array[i]
      filter_players(FileHandler.file_reader(DIR_TYPE, @file_name))
    end
  end

  def filter_players(player_hash)
    player_hash.each do |_club, player|
      player.each do |_player_name, attrib|
        rate_players(attrib)
      end
    end
    FileHandler.new(player_hash, File.basename(@file_name, '.json')).players_to_json
  end

  def rate_players(attrib)
    attacker_rating = attrib['Goals'].to_f + attrib['Assists'].to_f
    defender_rating = attrib['Tackles_won'].to_f + attrib['Int_&_blks'].to_f + attrib['Clearances'].to_f - (attrib['Errors'].to_f * 10)
    if attrib['Position'] == 'GK'
      gk_rating = (attrib['Save_%'].to_f * 100) + (attrib['Clean_sheet'].to_f * 10) - attrib['Goals_conceded'].to_f
      attrib.merge!('Goal_keeper_rating' => gk_rating.round(3))
    end
    attrib.merge!('Attacker_rating' => attacker_rating.round(3))
    attrib.merge!('Defender_rating' => defender_rating.round(3))
  end
end
