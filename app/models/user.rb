class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :predictions, dependent: :destroy
  has_many :predicted_matches, through: :predictions, source: :match

  def predict(match, home_score:, away_score:)
    predictions.find_or_initialize_by(match: match).tap do |prediction|
      prediction.update!(predicted_home_score: home_score, predicted_away_score: away_score)
    end
  end
end
