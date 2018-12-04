class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do|t|
      t.string :date
      t.integer :team1goals
      t.integer :team2goals
    end
  end
end
