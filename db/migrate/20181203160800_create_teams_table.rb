class CreateTeamsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :team_name
    end
  end
end
