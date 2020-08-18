class FileWriter
  TEAM_DIR_NAME = "./docs/clubs/"
  PLAYER_DIR_NAME = "./docs/players/"

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
    Dir.mkdir(dir) unless File.exists?(dir)
  end
end