class CreateBowlingGames < ActiveRecord::Migration
  def change
    create_table :bowling_games do |t|
      t.string :player_name
      t.string :player_email
      t.timestamps null: false
    end
  end
end
