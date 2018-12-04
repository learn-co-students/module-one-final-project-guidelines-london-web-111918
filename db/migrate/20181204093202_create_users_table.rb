class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :house
      t.integer :num_of_spellbooks
    end
  end
end
