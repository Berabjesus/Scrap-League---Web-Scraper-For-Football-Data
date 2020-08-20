require_relative '../lib/show_status.rb'

describe ShowStatus do
  let(:extended_class) { Class.new { extend ShowStatus } }
  let(:string1) { 'team' }

  it 'shows Scraping team data text' do
    output = extended_class.print_league_node(string1)
    expect(output).to eq(puts("Scraping team data about #{string1}"))
  end

  it 'shows Scraping player data text' do
    output = extended_class.print_player_node(string1, 5)
    expect(output).to eq(puts("Scraping player data about #{string1}\n" + " #{5 * 5} % \n"))
  end
end
