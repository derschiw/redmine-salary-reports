class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]


  # GET /reports/:id/report
  def report
    @report = Report.find(params[:report_id])
    respond_to do |format|
      format.pdf {
        puts "*"*100
        puts "Rendering PDF"
        puts "*"*100
      }
    end
  end

  # GET /reports or /reports.json
  def index
    @reports = Report.all.order(id: :asc)
  end

  # GET /reports/:id
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to report_url(@report), notice: "Report was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to report_url(@report), notice: "Report was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url, notice: "report was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:date_from, :date_to, :user_id)
    end

end
