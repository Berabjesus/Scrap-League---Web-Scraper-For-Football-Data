require 'colorize'
require_relative '../lib/interface_data_control.rb'

class Main
  def initialize; end

  def welcome_interface
    divide(1)
    divide(1)
    puts "\n\t\t\t\t Welcome to Scrape League \n\n"
    divide(1)
    divide(1)
    puts "\n"
  end

  def main_option
    puts "\n\t\t\t\t Choose Which Football league Stat You Want to Get \n"
    puts "\n\t\t\t\t 1.English_Premier_League \n"
    puts "\n\t\t\t\t 2.Spain_La_Liga \n"
    puts "\n\t\t\t\t 3.Germany_Bundesliga \n"
    puts "\n\t\t\t\t 4.Italian_Serie_A \n"
    puts "\n\t\t\t\t 5.France_Ligue1 \n"
    puts "\n\t\t\t\t 6.Exit \n".red

    option1 = validate((1..6), gets.chomp.to_i)
    abort_program(2) if option1 == 6
    clear_screen
    InterfaceDataControl.new.league_data_options(option1)
    clear_screen
  end

  def team_option
    divide(1)
    puts "\n\t\t\t\t What Information you wan to display \n"
    puts "\n\t\t\t\t 1.League table \n"
    puts "\n\t\t\t\t 2.Team stats \n"
    puts "\n\t\t\t\t 3.Suggest Best XI \n"
    puts "\n\t\t\t\t 4.Best Forward \n"
    puts "\n\t\t\t\t 5.Best midfielder \n"
    puts "\n\t\t\t\t 6.Best GoalKeeper \n"
    puts "\n\t\t\t\t 7.Exit \n".red
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