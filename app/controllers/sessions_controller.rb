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
  
    private
  
    def session_params
      params.require(:session).permit(:patient_id, :date, :amount)
    end
  end
    

