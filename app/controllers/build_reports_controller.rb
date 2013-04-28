class BuildReportsController < ApplicationController
  def index
    @reports = BuildReport.all
  end

  def show
    @report = BuildReport.find params[:id]
    @types = TaskType.all
  end

  def new
    #More of a 'request' sort of thing. User defines start, end,
    #and title (if desired) and the rest is computed in create.
  end

  def create
    @report = BuildReport.create! params[:build_report]
    flash[:notice] = "Build report #{@report.title} was successfully created."
    redirect_to build_reports_path
  end

  #no destroy method? Build reports should be kept permanently. I can use
  #rails console to delete my test reports, etc.
end
