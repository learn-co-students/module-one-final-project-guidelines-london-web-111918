class CreateBindSpellsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :bind_spells do |t|
      t.integer :spellbook_id
      t.integer :spell_id
    end
  end
end
