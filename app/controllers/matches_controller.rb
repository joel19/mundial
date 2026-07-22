class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: %i[ edit update ]

  def index
    @matches = Match.all
  end

  def edit
  end

  def update
    if @match.update(match_params)
      redirect_to matches_path, notice: "Marcador actualizado.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.expect(match: [ :home_team_score, :away_team_score ])
    end
end
