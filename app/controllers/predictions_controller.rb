class PredictionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: %i[ new create ]
  before_action :set_prediction, only: %i[ edit update destroy ]

  # GET /predictions
  def index
    @matches = Match.includes(:home_team, :away_team).all
    @predictions_by_match_id = current_user.predictions.index_by(&:match_id)
  end

  # GET /predictions/new?match_id=1
  def new
    existing_prediction = current_user.predictions.find_by(match: @match)
    return redirect_to edit_prediction_path(existing_prediction) if existing_prediction

    @prediction = current_user.predictions.new(match: @match)
  end

  # POST /predictions
  def create
    @prediction = current_user.predictions.find_or_initialize_by(match: @match)
    @prediction.assign_attributes(prediction_params)

    if @prediction.save
      redirect_to predictions_path, notice: "Pronóstico guardado."
    else
      render :new, status: :unprocessable_content
    end
  end

  # GET /predictions/1/edit
  def edit
  end

  # PATCH/PUT /predictions/1
  def update
    if @prediction.update(prediction_params)
      redirect_to predictions_path, notice: "Pronóstico actualizado.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  # DELETE /predictions/1
  def destroy
    @prediction.destroy!
    redirect_to predictions_path, notice: "Pronóstico eliminado.", status: :see_other
  end

  private
    def set_match
      @match = Match.find(params[:match_id])
    end

    def set_prediction
      @prediction = current_user.predictions.find(params[:id])
    end

    def prediction_params
      params.expect(prediction: [ :predicted_home_score, :predicted_away_score ])
    end
end
