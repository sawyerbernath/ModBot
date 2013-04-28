class BuildReportsController < ApplicationController
  # GET /build_reports
  # GET /build_reports.json
  def index
    @build_reports = BuildReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @build_reports }
    end
  end

  # GET /build_reports/1
  # GET /build_reports/1.json
  def show
    @build_report = BuildReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build_report }
    end
  end

  # GET /build_reports/new
  # GET /build_reports/new.json
  def new
    @build_report = BuildReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build_report }
    end
  end

  # GET /build_reports/1/edit
  def edit
    @build_report = BuildReport.find(params[:id])
  end

  # POST /build_reports
  # POST /build_reports.json
  def create
    @build_report = BuildReport.new(params[:build_report])

    respond_to do |format|
      if @build_report.save
        format.html { redirect_to @build_report, notice: 'Build report was successfully created.' }
        format.json { render json: @build_report, status: :created, location: @build_report }
      else
        format.html { render action: "new" }
        format.json { render json: @build_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /build_reports/1
  # PUT /build_reports/1.json
  def update
    @build_report = BuildReport.find(params[:id])

    respond_to do |format|
      if @build_report.update_attributes(params[:build_report])
        format.html { redirect_to @build_report, notice: 'Build report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @build_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /build_reports/1
  # DELETE /build_reports/1.json
  def destroy
    @build_report = BuildReport.find(params[:id])
    @build_report.destroy

    respond_to do |format|
      format.html { redirect_to build_reports_url }
      format.json { head :no_content }
    end
  end
end
