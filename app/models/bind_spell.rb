class BindSpell < ActiveRecord::Base
  belongs_to :spellbook
  belongs_to :spell
end
