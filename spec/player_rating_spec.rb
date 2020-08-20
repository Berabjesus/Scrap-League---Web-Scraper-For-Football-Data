require_relative '../lib/players_rating.rb'

describe PlayersRating do
  it 'Raises argument error when arguments are given' do
    expect { PlayersRating.new('value') }.to raise_error(ArgumentError)
  end
end
