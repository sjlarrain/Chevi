# app/controllers/patients_controller.rb
class PatientsController < ApplicationController
    def new
      @patient = Patient.new
    end
  
    def create
      @patient = Patient.new(patient_params)
      if @patient.save
        redirect_to root_path, notice: "Patient was successfully created."
      else
        render :new
      end
    end
  
    private
  
    def patient_params
      params.require(:patient).permit(:rut, :name, :mother_name, :phone_number, :email, :address)
    end
  end
