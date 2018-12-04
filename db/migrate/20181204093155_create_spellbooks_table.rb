class CreateSpellbooksTable < ActiveRecord::Migration[5.0]
  def change
    create_table :spellbooks do |t|
      t.string :type
      t.integer :num_of_spells
      t.integer :user_id
    end
  end
end
