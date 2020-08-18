# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'json'

class MainScraper
  def initialize(url)
    @url = url
    
    parse_url
  end

  def parse_url
    @parsed_url = Nokogiri::HTML(URI.open(@url))
    @first = @parsed_url.at('tbody')
    @table_rows = @first.css('tr')
    @hash_1 = {}
    h_array = %i[
      name
      Matches_Played
      Win
      Draw
      Lost
      GF
      GA
      GDiff
      points
      XG
      XGA
      XGDiff
      XGDiff_90
      url
    ]
    # @first[0].css('td').length.times do |i|
    @table_rows.length.times do |i|
      @hash_1[@table_rows[i].css('td')[0].text] = {}
      # @hash_1.merge!( h_array[0] => 'gfdgdf')
      (h_array.length - 1).times do |j|
        @hash_1[@table_rows[i].css('td')[0].text].merge!(h_array[j] => @table_rows[i].css('td')[j].text)
      end
      @hash_1[@table_rows[i].css('td')[0].text].merge!(h_array[-1] => @table_rows[i].css('td')[0].css('a').first['href'])
    end
    p @hash_1 = @hash_1.sort_by { |club_name, _attrib| club_name }.to_h
    File.write('./lib/sample.json', JSON.dump(@hash_1))
  end
end

# file = File.read('./lib/sample.json')
# data_hash1 = JSON.parse(file)
# p data_hash1
# File.write('./lib/sample.json', JSON.dump(hash1))

dir = Dir.pwd
# url3 = File.open("#{dir.to_s}/lib/test.html")
url4 = 'https://fbref.com/en/comps/9/Premier-League-Stats'
new_file = MainScraper.new(url4)
