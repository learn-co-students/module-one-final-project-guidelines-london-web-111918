class CreatePlayersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :second_name
      t.integer :total_points
      t.integer :cost_of_player
      t.integer :user_id
      t.integer :team_id
    end
  end
end
