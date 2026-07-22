class CreateNationalTeams < ActiveRecord::Migration[8.1]
  def change
    create_table :national_teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
