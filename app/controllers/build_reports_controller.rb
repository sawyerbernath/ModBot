class BuildReportsController < ApplicationController
  def index
    @reports = BuildReport.all
  end

  def show
    @report = BuildReport.find params[:id]
    @type_names = TaskType.where('name != ""').map do |t|
      t.name.gsub(/ /, '').underscore
    end
    @total_built = 0
    @total_passed = 0.0
    @total_failed = 0.0
    @total_hours = 0.0
    @type_names.each do |t|
      p = @report["#{t}_passed"]
      f = @report["#{t}_failed"]
      if p
        @total_passed = @total_passed + p
      end
      if f
        @total_failed = @total_failed + f
      end
      if p && TaskType.find_by_name(t.titleize).final
        @total_built = @total_built + p
      end
      @total_hours = @total_hours + @report["#{t}_hours"]
    end
  end

  def new
    #More of a 'request' sort of thing. User defines start, end,
    #and title (if desired) and the rest is computed in create.
  end

  def create
    @report = BuildReport.create! params[:build_report]
    @start = Time.zone.local(params[:build_report]['start(1i)'].to_i, 
                             params[:build_report]['start(2i)'].to_i,
                             params[:build_report]['start(3i)'].to_i,
                             params[:build_report]['start(4i)'].to_i,
                             params[:build_report]['start(5i)'].to_i)
    @end = Time.zone.local(params[:build_report]['end(1i)'].to_i, 
                           params[:build_report]['end(2i)'].to_i,
                           params[:build_report]['end(3i)'].to_i,
                           params[:build_report]['end(4i)'].to_i,
                           params[:build_report]['end(5i)'].to_i)

    @tasks = Task.select do |t|
      t.status == 'Completed' && t.updated_at > @start && t.updated_at < @end
    end
    
    @tasks.each do |t|
      #format task names as in :build_report database
      t_name = t.task_type.name.gsub(/ /, '').underscore
      #add all tested tasks into BuildReport
      if t.task_type.test
        @report["#{t_name}_passed"] = @report["#{t_name}_passed"] + t.passed
        @report["#{t_name}_failed"] = @report["#{t_name}_failed"] + t.failed
      end
      #copy all tasks' hours into BuildReport
      @report["#{t_name}_hours"] = t.hours_in_progress
    end
    @report.save

    flash[:notice] = "Build report #{@report.title} was successfully created."
    redirect_to build_report_path @report
  end

  #no destroy method? Build reports should be kept permanently. I can use
  #rails console to delete my test reports, etc.
end
