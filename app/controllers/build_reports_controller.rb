class BuildReportsController < ApplicationController
  def index
    @reports = BuildReport.all
  end

  def show
    @report = BuildReport.find params[:id]
  end

  def new
    #More of a 'request' sort of thing. User defines start, end,
    #and title (if desired) and the rest is computed in create.
  end

  def create
  end

  #no destroy method? Build reports should be kept permanently. I can use
  #rails console to delete my test reports, etc.
end
