# app/controllers/patients_controller.rb
class PatientsController < ApplicationController
    before_action :set_patient, only: [:toggle_active]

    # Toggle active status
    def toggle_active
      @patient.update(active: !@patient.active) # Toggle the active status
      redirect_to my_patients_path, notice: "Patient status updated successfully."
    end

    private

    def set_patient
      @patient = Patient.find(params[:id])
    end
  
    
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
