class WelcomeController < ApplicationController
  def index
    @teams = Team.includes(:events) # Eager load events for teams
  end
end
 