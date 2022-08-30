class SalaryReportsController < ApplicationController
  before_action :set_salary_report, only: %i[ show edit update destroy ]


  # GET /salary_reports/:id/report
  def report
    @salary_report = SalaryReport.find(params[:salary_report_id])
    respond_to do |format|
      format.pdf {
        puts "*"*100
        puts "Rendering PDF"
        puts "*"*100
      }
    end
  end

  # GET /salary_reports or /salary_reports.json
  def index
    @salary_reports = SalaryReport.all.order(id: :asc)
  end

  # GET /salary_reports/:id
  def show
  end

  # GET /salary_reports/new
  def new
    @salary_report = SalaryReport.new
  end

  # GET /salary_reports/1/edit
  def edit
  end

  # POST /salary_reports or /salary_reports.json
  def create
    @salary_report = SalaryReport.new(salary_report_params)

    respond_to do |format|
      if @salary_report.save
        format.html { redirect_to salary_report_url(@salary_report), notice: "Report was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /salary_reports/1 or /salary_reports/1.json
  def update
    respond_to do |format|
      if @salary_report.update(salary_report_params)
        format.html { redirect_to salary_report_url(@salary_report), notice: "Report was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salary_reports/1 or /salary_reports/1.json
  def destroy
    @salary_report.destroy

    respond_to do |format|
      format.html { redirect_to salary_reports_url, notice: "report was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_salary_report
      @salary_report = SalaryReport.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def salary_report_params
      params.require(:salary_report).permit(:date_from, :date_to, :user_id)
    end

end
