# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
    before_action :authenticate_professional!
  
    def new
      @session = Session.new
    end
  
    def create
      @session = Session.new(session_params)
      @session.professional = current_professional
      if @session.save
        redirect_to root_path, notice: "Session was successfully created."
      else
        render :new
      end
    end
  
    private
  
    def session_params
      params.require(:session).permit(:patient_id, :date, :amount)
    end
  end
