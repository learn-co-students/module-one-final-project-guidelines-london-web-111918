class Match < ActiveRecord::Base

  has_many :matchteams
  has_many :teams, through: :matchteams

end
