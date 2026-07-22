require "csv"

CSV.foreach(Rails.root.join("db/seeds/teams.csv"), headers: true) do |row|
  next if row["name"].blank?

  NationalTeam.find_or_create_by!(name: row["name"]) do |team|
    team.confederation = row["confederation"]
    team.host = row["host"] == "true"
    team.debutant = row["debutant"] == "true"
  end
end
