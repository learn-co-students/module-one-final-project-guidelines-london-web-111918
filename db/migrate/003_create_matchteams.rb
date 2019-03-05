class CreateMatchteams < ActiveRecord::Migration
  def change
    create_table :match_teams do|t|
      t.integer :match_id
      t.integer :team1_id
      t.integer :team2_id
    end
  end
end
