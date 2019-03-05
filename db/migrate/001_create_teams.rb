class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do|t|
      t.string :name
      t.string :colours
      t.string :stadium
      t.string :address
      t.integer :founded
    end
  end
end
