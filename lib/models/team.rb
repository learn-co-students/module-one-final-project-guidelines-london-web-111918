class Team < ActiveRecord::Base

  has_many :matchteams
  has_many :matches, through: :matchteams

end
