module ShowStatus
  def print_league_node(current_node)
    puts "Scraping team data about #{current_node}"
  end

  def print_player_node(current_node, num)
    puts "Scraping player data about #{current_node}"
    num.times { print '||' }
    print " #{num * 5} % \n"
  end
end
