unless Match.exists?
  NationalTeam.all.to_a.shuffle.each_slice(4) do |group|
    group.combination(2).each do |team_a, team_b|
      home, away = [ team_a, team_b ].shuffle

      Match.create!(home_team_id: home.id, away_team_id: away.id)
    end
  end
end
