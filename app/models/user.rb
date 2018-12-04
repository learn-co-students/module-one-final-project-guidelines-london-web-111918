class User < ActiveRecord::Base
  has_many :spellbooks
  has_many :spells, through: :spellbooks
end
