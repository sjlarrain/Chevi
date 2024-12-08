class HomeController < ApplicationController
  def index
  end
  
  def my_patients
    # Get all patients for the current professional
    @patients = Patient.joins(:sessions).where(sessions: { professional_id: current_professional.id }).distinct
  end

  # My Sessions action
  def my_sessions
    # Get all sessions for the current professional
    @sessions = current_professional.sessions.includes(:patient)
  end
end
