require_relative '../lib/interface_data_control.rb'

describe InterfaceDataControl do
  let(:new_class) { InterfaceDataControl.new }

  it 'Raises argument error when less than two arguments are given' do
    expect { InterfaceDataControl.new('value') }.to raise_error(ArgumentError)
  end

  it 'Raises argument error when league_data_options is not given an argument' do
    expect { new_class.league_data_options }.to raise_error(ArgumentError)
  end

  it 'Raises no file directory error when suggest_best_xi called when the league variable is not given' do
    expect { new_class.suggest_best_xi }.to raise_error(Errno::ENOENT)
  end

  it 'Raises no file directory error when gets_league_hash called when the league variable is not given' do
    expect { new_class.gets_league_hash }.to raise_error(Errno::ENOENT)
  end

  it 'Raises no file directory error when gets_team_hash called when the league variable is not given' do
    expect { new_class.gets_team_hash }.to raise_error(Errno::ENOENT)
  end

  context 'When no argument is given' do
    it 'Raises argument error when more than two arguments are given' do
      expect { new_class.gets_player_hash('a', 'b', 'c') }.to raise_error(ArgumentError)
    end
  end

  context 'When argument is given' do
    it 'Raises no file directory error when gets_player_hash called when the league variable is not given' do
      expect { new_class.gets_player_hash }.to raise_error(Errno::ENOENT)
    end
  end
end
