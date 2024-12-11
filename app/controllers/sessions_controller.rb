# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    before_action :authenticate_professional!
  
    def new
      @session = Session.new
    end
  
    def create
      @session = current_professional.sessions.build(session_params)
  
      if @session.save
        redirect_to home_index_path, notice: "Session created successfully."
      else
        render :new
      end
    end
    
    def mark_as_paid
      @session = Session.find(params[:id])
      if @session.update(payment: true)
        redirect_to home_my_sessions_path, notice: "Session marked as paid."
      else
        redirect_to home_my_sessions_path, alert: "Failed to mark the session as paid."
      end
    end
  
    private
  
    def session_params
      params.require(:session).permit(:patient_id, :date, :amount)
    end
  end
    

