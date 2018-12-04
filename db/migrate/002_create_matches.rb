class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do|t|
      t.string :date
      t.string :team1
      t.integer :team1goals
      t.string :team2
      t.integer :team2goals
    end
  end
end
