class Match < ApplicationRecord
  belongs_to :home_team, class_name: 'NationalTeam'
  belongs_to :away_team, class_name: 'NationalTeam'

  has_many :predictions, dependent: :destroy

  default_scope { order(:created_at) }

  validates :home_team_score, numericality: { greater_than_or_equal_to: 0 }
  validates :away_team_score, numericality: { greater_than_or_equal_to: 0 }
end
