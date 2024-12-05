class EventsController < ApplicationController
  before_action :authenticate_coach!, except: [:index, :show, :team_events_json] # Exclude team_events_json
  before_action :set_event, only: %i[show edit update destroy]

  # events json for calendar
  def team_events_json
    @team = Team.find(params[:team_id])
    @events = @team.events
  
    json_response = @events.map do |event|
      {
        id: event.id,
        title: event.name, # Correctly mapped for FullCalendar
        start: event.date.in_time_zone.strftime('%Y-%m-%d %H:%M'), # Converts to local time & 24-hour format
        allDay: false,
        location: event.location
      }
    end
  
    Rails.logger.debug "Generated JSON: #{json_response.to_json}"
  
    render json: json_response
  end

  # GET /events
  def index
    @team = Team.find(params[:team_id]) # Fetch the specific team
    @events = @team.events             # Fetch events for the team
  end

  # GET /events/1 or /events/1.json
  def show
    @team = Team.find(params[:team_id])    # Find the team using the team_id from the route
    @event = @team.events.find(params[:id])  # Find the event within that team
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    
    if params[:event][:team_id].present?
      @event.team = Team.find_by(id: params[:event][:team_id])
      unless @event.team
        @event.errors.add(:team, "is invalid")
      end
    else
      @event.errors.add(:team, "must be selected")
    end
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to team_events_path(@event.team), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to team_events_path(@event.team), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!
  
    respond_to do |format|
      format.html { redirect_to team_events_path(@event.team), status: :see_other, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
      @team = @event.team
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date, :location, :team_id)
    end
end
