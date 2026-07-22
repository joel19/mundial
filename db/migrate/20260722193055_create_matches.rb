class CreateMatches < ActiveRecord::Migration[8.1]
  def change
    create_table :matches do |t|
      t.timestamps
      t.references :home_team, null: false, foreign_key: { to_table: :national_teams }
      t.references :away_team, null: false, foreign_key: { to_table: :national_teams }
      t.integer :home_team_score, null: false, default: 0
      t.integer :away_team_score, null: false, default: 0
    end
  end
end
