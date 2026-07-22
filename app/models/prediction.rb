class Prediction < ApplicationRecord
  belongs_to :user
  belongs_to :match

  validates :predicted_home_score, numericality: { greater_than_or_equal_to: 0 }
  validates :predicted_away_score, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, uniqueness: { scope: :match_id }

  def correct?
    (predicted_home_score <=> predicted_away_score) == (match.home_team_score <=> match.away_team_score)
  end
end
