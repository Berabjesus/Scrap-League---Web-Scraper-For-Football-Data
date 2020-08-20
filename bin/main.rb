require 'colorize'
require 'terminal-table'
require_relative '../lib/interface_data_control.rb'
require_relative '../lib/constants.rb'
class Main
  def initialize 
    @interface = InterfaceDataControl.new
    @data_shelf = []
    welcome_interface
  end

  def welcome_interface
    divide(1)
    divide(1)
    puts "\n\t\t\t\t Welcome to Scrape League \n\n"
    divide(1)
    divide(1)
    puts "\n"
    main_option
  end

  def main_option
    puts "\n\t\t\t\t Choose Which Football league Stat You Want to Get \n"
    puts "\n\t\t\t\t 1.English_Premier_League \n"
    puts "\n\t\t\t\t 2.Spain_La_Liga \n"
    puts "\n\t\t\t\t 3.Germany_Bundesliga \n"
    puts "\n\t\t\t\t 4.Italian_Serie_A \n"
    puts "\n\t\t\t\t 5.France_Ligue1 \n"
    puts "\n\t\t\t\t 6.Exit \n".red
    option = validate((1..6), gets.chomp.to_i)
    abort_program(2) if option == 6
    @league_chosen = CLUB_WEBSITE.keys[option - 1]
    clear_screen
    @interface.league_data_options(option) if @data_shelf.none?(option)
    @interface.league = CLUB_WEBSITE.keys[option - 1]
    @data_shelf << option if @data_shelf.none?(option)
    clear_screen
    team_option
  end

  def team_option
    divide(1)
    puts "\n\t\t\t\t What Information you want to display \n"
    puts "\n\t\t\t\t 1.League table \n"
    puts "\n\t\t\t\t 2.Team stats \n"
    puts "\n\t\t\t\t 3.Suggest Best XI \n"
    puts "\n\t\t\t\t 4.Best Forward \n"
    puts "\n\t\t\t\t 5.Best midfielder \n"
    puts "\n\t\t\t\t 6.Best defender \n"
    puts "\n\t\t\t\t 7.Best GoalKeeper \n"
    puts "\n\t\t\t\t 8.Exit \n".red
    option = validate((1..8), gets.chomp.to_i)
    abort_program(2) if option == 8
    clear_screen
    if option == 1
      League_table_interface()
    elsif option == 2
      players_table_interface()
    else
      suggest_players(option)
    end
  end

  def League_table_interface
    divide(1)
    data = @interface.gets_league_hash
    rows = []
    data.values.length.times do |k|
      row = []
      (data.values[k].values.length - 1).times do |l|
        row << data.values[k].values[l]
      end
      rows << row
    end
    table = Terminal::Table.new :headings => TEAM_STAT_TYPE, :rows => rows
    puts table
    navigate
  end

  def players_table_interface
    divide(1)
    teams = @interface.gets_team_hash
    puts "\n\t\t\t\t Choose a team \n"
    teams.length.times do |i|
      puts "#{i+1} #{teams[i]}"
    end
    option = validate((1..20), gets.chomp.to_i)

    player_data = @interface.gets_player_hash(@league_chosen, option)
    header = ['Name','N', 'P', 'A', 'MP', 'S', 'Mi', 'G', 'A', 'PK', 'PKA', 'YC', 'RC', 'G90', 'A90', 'GA90', 'T', 'TW', 'BL', 'In', 'CL', 'Er', 'AR', 'DR']

    table = Terminal::Table.new :headings =>header, :rows => player_data[option - 1]
    puts table
    navigate
  end

  def suggest_players(option)
    best_palyers = @interface.suggest_best_xi
    if option == 3
      divide(1)
      puts "ATTACKERS"
      puts best_palyers[0]
      divide(1)
      puts "MIDFIELDERS"
      puts best_palyers[1]
      divide(1)
      puts "DEFENDERS"
      puts best_palyers[2]
      divide(1)
      puts "GOALKEEPER"
      puts best_palyers[3]

    elsif option == 4
      puts best_palyers[0][0]
    elsif option == 5
      puts best_palyers[1][0]
    elsif option == 6
      puts best_palyers[2][0]
    elsif option == 7
      puts best_palyers[3][0]
    end
    navigate
  end
  
  def navigate
    puts "\n\t 1.Change League \n"
    puts "\n\t 2.Change Team option \n"
    puts "\n\t 3.Exit \n".red
    option = validate((1..3), gets.chomp.to_i)
    clear_screen
    main_option if option == 1
    team_option if option == 2
    abort_program(2) if option == 3
  end

  def validate(range, input)
    try = 4
    while range.none?(input) && try.positive?
      puts " Please choose a Number Between #{range} you have #{try} trials left".yellow
      break if range.any?(input = gets.chomp.to_i)
  
      try -= 1
    end
    input
  end

  def divide(num)
    if num == 1
      100.times { print '#'.black.on_cyan }
    else
      100.times { print '!'.black.on_red }
    end
    print "\n"
  end

  def clear_screen
    system 'cls'
    system 'clear'
  end

  def abort_program(status)
    if status == 1
      abort 'Too many wrong inputs, Exiting . . .'.on_red
    elsif status == 2
      abort 'Thank you for using Scrap League, Exiting . . .'.on_red
    end
  end
end

Main.new