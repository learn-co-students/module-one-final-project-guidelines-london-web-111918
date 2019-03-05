class Spell < ActiveRecord::Base
  has_many :bind_spells
  has_many :spellbooks, through: :bind_spells
end
