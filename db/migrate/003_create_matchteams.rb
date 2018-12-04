class CreateMatchteams < ActiveRecord::Migration
  def change
    create_table :matchteams do|t|
      t.integer :match_id
      t.integer :team_id
    end
  end
end
