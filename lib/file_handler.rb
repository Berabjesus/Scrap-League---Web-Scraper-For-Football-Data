# frozen_string_literal: true

require 'json'
class FileHandler
  TEAM_DIR_NAME = './docs/clubs/'
  PLAYER_DIR_NAME = './docs/players/'

  def initialize(hash, file_name)
    @hash = hash
    @file_name = file_name
  end

  def teams_to_json
    dir_maker(TEAM_DIR_NAME)
    File.write("#{TEAM_DIR_NAME}#{@file_name}.json", JSON.dump(@hash))
  end

  def players_to_json
    dir_maker(PLAYER_DIR_NAME)
  end

  def dir_maker(dir)
    Dir.mkdir(dir) unless File.exist?(dir)
  end

  def self.file_reader(dir_type, file_name)
    return JSON.parse(File.read("#{TEAM_DIR_NAME}#{file_name}.json")) if dir_type == 'CLUBS'
  end
end
