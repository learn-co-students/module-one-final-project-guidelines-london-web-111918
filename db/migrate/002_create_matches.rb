class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do|t|
      t.string :date
      t.integer :team1_goals
      t.integer :team2_goals
      t.integer :match_no
    end
  end
end
