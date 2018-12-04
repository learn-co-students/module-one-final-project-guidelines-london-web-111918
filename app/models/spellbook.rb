class Spellbook < ActiveRecord::Base
  belongs_to :user
  has_many :bind_spells
  has_many :spells, through: :bind_spells
end
