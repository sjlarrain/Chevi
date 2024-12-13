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

    def financial_panel
      @months = Session.select("DISTINCT strftime('%m', date) AS month, strftime('%Y', date) AS year")
      .order("year DESC, month DESC")
    end
  
    def monthly_summary
      month = params[:month].to_i
      year = params[:year].to_i
  
      @sessions = current_professional.sessions.by_month(month, year)
      @gross_income = @sessions.sum(:amount)
      @tax_amount = (@gross_income * 0.1375).round(2)
      @net_income = (@gross_income - @tax_amount).round(2)
  
      respond_to do |format|
        format.html
        format.xlsx { send_data generate_excel(@sessions), filename: "sessions_#{month}_#{year}.xlsx" }
      end
    end
  
    private
  
    def session_params
      params.require(:session).permit(:patient_id, :date, :amount)
    end

    def generate_excel(sessions)
      Axlsx::Package.new do |p|
        p.workbook.add_worksheet(name: "Monthly Report") do |sheet|
          sheet.add_row %w[PatientName PatientRUT MotherEmail Date Amount Status]
          sessions.each do |session|
            sheet.add_row [
              session.patient.name,
              session.patient.rut,
              session.patient.email,
              session.date.strftime("%d/%m/%Y"),
              session.amount,
              session.payment ? 'Paid' : 'Pending'
            ]
          end
        end
      end.to_stream.read
    end
  end
    

