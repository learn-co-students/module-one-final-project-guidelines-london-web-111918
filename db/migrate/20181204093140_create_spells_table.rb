class CreateSpellsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :spells do |t|
      t.string :name
      t.string :spell_type
      t.string :effect
    end
  end
end
