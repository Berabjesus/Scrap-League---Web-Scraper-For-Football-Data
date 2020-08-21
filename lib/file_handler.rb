require_relative './constants.rb'
require 'json'
require 'fileutils'
class FileHandler
  def initialize(hash, file_name)
    @hash = hash
    @file_name = file_name
  end

  def teams_to_json
    dir_maker(TEAM_DIR)
    File.write("#{TEAM_DIR}#{@file_name}.json", JSON.pretty_generate(@hash))
  end

  def players_to_json
    dir_maker(PLAYERS_DIR)
    players_file_name = "#{@file_name}.json"

    if File.file?("#{PLAYERS_DIR}#{players_file_name}") && File.read("#{PLAYERS_DIR}#{players_file_name}") != ''
      file = JSON.parse(File.read("#{PLAYERS_DIR}#{players_file_name}"))
      file.merge!(@hash)
      File.write("#{PLAYERS_DIR}#{players_file_name}", JSON.pretty_generate(file))
    else
      File.write("#{PLAYERS_DIR}#{players_file_name}", JSON.pretty_generate(@hash))
    end
  end

  def self.file_reader(dir_type, file_name)
    return JSON.parse(File.read("#{TEAM_DIR}#{file_name}.json")) if dir_type == 'CLUBS'
    return JSON.parse(File.read(file_name)) if dir_type == 'PLAYERS'
  end

  def self.access_all_players_files
    Dir["#{PLAYERS_DIR}*.json"]
  end

  private

  def dir_maker(dir)
    FileUtils.mkdir_p(dir) unless File.exist?(dir)
  end
end
