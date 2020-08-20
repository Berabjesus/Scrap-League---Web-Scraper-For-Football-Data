# frozen_string_literal: true

module ShowStatus
  def print_league_node(current_node)
    puts "Scraping team data about #{current_node}"
  end

  def print_player_node(current_node, i)
    puts "Scraping player data about #{current_node}"
    i.times {print '||'}
    print " #{i * 5} % \n"
  end
end
