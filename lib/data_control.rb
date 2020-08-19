# frozen_string_literal: true
require_relative './constants.rb'

class DataControl
  CLUB_WEBSITE = {
    English_Premier_League: 'https://fbref.com/en/comps/9/Premier-League-Stats',
    Spain_La_Liga: 'https://fbref.com/en/comps/13/3243/2019-2020-Ligue-1-Stats',
    Germany_Bundesliga: 'https://fbref.com/en/comps/20/Bundesliga-Stats',
    Italian_Serie_A: 'https://fbref.com/en/comps/11/Serie-A-Stats',
    France_Ligue1: 'https://fbref.com/en/comps/13/3243/2019-2020-Ligue-1-Stats'
  }.freeze

  def initialize
    p TEAM_STAT_TYPE
  end
end

DataControl.new