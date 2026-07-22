class AddAdditionalColumnsToNationalTeams < ActiveRecord::Migration[8.1]
  def change
    add_column :national_teams, :confederation, :string
    add_column :national_teams, :host, :boolean, default: false
    add_column :national_teams, :debutant, :boolean, default: false
  end
end
