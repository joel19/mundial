class NationalTeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_national_team, only: %i[ show edit update destroy ]

  # GET /national_teams or /national_teams.json
  def index
    @national_teams = NationalTeam.all
  end

  # GET /national_teams/1 or /national_teams/1.json
  def show
  end

  # GET /national_teams/new
  def new
    @national_team = NationalTeam.new
  end

  # GET /national_teams/1/edit
  def edit
  end

  # POST /national_teams or /national_teams.json
  def create
    @national_team = NationalTeam.new(national_team_params)

    respond_to do |format|
      if @national_team.save
        format.html { redirect_to @national_team, notice: "National team was successfully created." }
        format.json { render :show, status: :created, location: @national_team }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @national_team.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /national_teams/1 or /national_teams/1.json
  def update
    respond_to do |format|
      if @national_team.update(national_team_params)
        format.html { redirect_to @national_team, notice: "National team was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @national_team }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @national_team.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /national_teams/1 or /national_teams/1.json
  def destroy
    @national_team.destroy!

    respond_to do |format|
      format.html { redirect_to national_teams_path, notice: "National team was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_national_team
      @national_team = NationalTeam.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def national_team_params
      params.expect(national_team: [ :name, :confederation, :host, :debutant ])
    end
end
