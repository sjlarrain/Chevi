class HomeController < ApplicationController
  def index
  end
  
  def my_patients
    # Get all patients for the current professional
    @patients = current_professional.patients
  end

  # My Sessions action
  def my_sessions
    # Get all sessions for the current professional
    @sessions = current_professional.sessions.includes(:patient)
  end
end
