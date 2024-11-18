class TeamsController < ApplicationController
  before_action :authenticate_coach!, except: [:index, :show]
  before_action :set_team, only: %i[ show edit update destroy ]

  # GET /teams or /teams.json
  def index
    if coach_signed_in?
      @teams = current_coach.teams
    else
      @teams = Team.all
    end
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # Dashboard for after the coach logs in

  def dashboard
    @coach = current_coach
    @teams = @coach.teams
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    @team.coach = current_coach
  
    # Assign selected players to the team
    if params[:player_ids]
      players = Player.find(params[:player_ids])
      @team.players = players
    end
  
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end  

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to teams_path, status: :see_other, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :coach_id, player_ids: [])
    end
end
