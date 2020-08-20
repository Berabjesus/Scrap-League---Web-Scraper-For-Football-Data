require_relative '../lib/player_scraper.rb'

describe PlayerScraper do
  it 'Raises argument error when less than two arguments are given' do
    expect { PlayerScraper.new }.to raise_error(ArgumentError)
  end
end
