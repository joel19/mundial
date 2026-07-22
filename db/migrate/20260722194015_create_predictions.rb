class CreatePredictions < ActiveRecord::Migration[8.1]
  def change
    create_table :predictions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true
      t.integer :predicted_home_score, null: false
      t.integer :predicted_away_score, null: false

      t.timestamps
    end

    add_index :predictions, [ :user_id, :match_id ], unique: true
  end
end
