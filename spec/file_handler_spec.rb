require_relative '../lib/file_handler.rb'

describe FileHandler do
  let(:new_class) { FileHandler.new(hash, 'file.json') }

  it 'Raises argument error when no arguments are given' do
    expect { FileHandler.new }.to raise_error(ArgumentError)
  end

  it 'Raises argument error when more than two arguments are given' do
    expect { FileHandler.new('a', 'b', 'c') }.to raise_error(ArgumentError)
  end

  it 'Raises argument error when no arguments are given' do
    expect { FileHandler.new.file_reader }.to raise_error(ArgumentError)
  end

  it 'Raises argument error when more than two arguments are given' do
    expect { FileHandler.new.file_reader('a', 'b', 'c') }.to raise_error(ArgumentError)
  end
end
