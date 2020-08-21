require_relative './constants.rb'
require_relative './parser.rb'
require_relative './file_handler'
require_relative './show_status.rb'

class TeamScraper < Parser
  include ShowStatus

  def initialize(url, league)
    @url = url
    @league = league
    @team_hash = {}
    parse_teams
  end

  private

  def parse_teams
    parsed_url = parse
    table_rows = parsed_url.at('tbody').css('tr')
    table_rows.length.times do |i|
      @team_hash[table_rows[i].css('td')[0].text.strip] = {}
      print_league_node(table_rows[i].css('td')[0].text.strip)
      (TEAM_STAT_TYPE.length - 1).times do |j|
        @team_hash[table_rows[i].css('td')[0].text.strip].merge!(TEAM_STAT_TYPE[j] => table_rows[i].css('td')[j].text)
      end
      @team_hash[table_rows[i].css('td')[0].text.strip].merge!(TEAM_STAT_TYPE[-1] => table_rows[i].css('td')[0].css('a').first['href'])
    end
    FileHandler.new(@team_hash, @league).teams_to_json
  end
end
