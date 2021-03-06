class TasksController < ApplicationController
  def index
    @blank_type = (TaskType.where 'name == ""').last
    if @blank_type
      @blank_type_id = @blank_type.id
    else
      @blank_type_id = nil
    end
    @tasks = Task.where('task_type_id != ?', @blank_type_id)
  end

  def show
    @task = Task.find(params[:id]) # look up task by passed id
  end

  def new
    @tasktypes = TaskType.where('name != ""').map {|t| [t.name, t.id]}
  end

  def create
    params[:task][:status] = 'Posted'
    @task = Task.create!(params[:task].slice(:status, :quantity, :notes))
    @task.elf = (Elf.where 'name = ""').first
    @task.task_type = TaskType.find params[:task][:task_type]
    @task.save
    flash[:notice] = "Task #{@task.id} was successfully created."
    redirect_to tasks_path
  end

  def edit
    @task = Task.find params[:id]
    @tasktypes = TaskType.where('name != ""').map {|t| [t.name, t.id]}
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes!(params[:task].slice(:quantity, :notes, :passed, :failed))
    @task.task_type = TaskType.find params[:task][:task_type_id]
    @task.save
    flash[:notice] = "Task \##{@task.id} was successfully updated."
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    flash[:notice] = "Task \##{@task.id}:#{@task.task_type.name} deleted."
    redirect_to tasks_path
  end

  def select_index
    @ptasks = Task.select {|t| t.status == 'Posted'}
    @elves = Elf.where('name != ""').map {|e| [e.name, e.id]}
  end

  def select
    @task = Task.find params[:id]
    @elf = Elf.find params[:elf]
    hours = (Time.now - @task.created_at) / 3600
    @task.update_attributes!(:status => 'In Progress',
                             :hours_posted => hours)
    @task.elf = @elf
    @task.save
    flash[:notice] = "Task \##{@task.id} was taken."
    redirect_to home_path
  end

  def complete_index
    @iptasks = Task.select {|t| t.status == 'In Progress'}
  end

  def complete
    @task = Task.find params[:task_id]
    hours = (Time.now - @task.updated_at) / 3600
    if @task.task_type.test == false   #Task with no associated test           
      @task.update_attributes!(:status => 'Completed',
                               :hours_in_progress => hours)
      flash[:notice] = "#{@task.elf.name} completed task \##{@task.id}."
      redirect_to home_path
    elsif params[:tested]              #Pass/fail numbers input successfully
      @task.update_attributes!(:status => 'Completed', 
                               :passed => params[:passed],
                               :failed => params[:failed],
                               :hours_in_progress => hours)
      flash[:notice] = "#{@task.elf.name} completed and tested task \##{@task.id}."
      redirect_to home_path
    else                               #Needs pass/fail numbers
      @buttons = Hash.new
      @task.quantity.downto(1) do |n|
        text = n
        confirmation = "So #{@task.quantity - n} failed?"
        passed = n
        failed = @task.quantity - n
        @buttons[n] = {:text => text, :confirmation => confirmation,
          :passed => passed, :failed => failed}
      end
      render "/passfail.html.haml/"
    end
  end

  def home
    @buttons = Hash.new
    @clock = fetch_elves
    (Elf.where 'name != ""').each do |e|
      if (e.tasks.last.task_type.name == '' ||   #Elf is new
          e.tasks.last.status == 'Completed')    #Last task was completed.
        text = "#{e.name}. Click to select task."
        path = select_index_elf_path(e)
        method = :get
        confirmation = false

      else
        text = "#{e.name}. Current task: #{e.tasks.last.id}, " +
          "#{e.tasks.last.task_type.name}.  CLICK TO COMPLETE TASK."
        path = complete_tasks_path(:task_id => e.tasks.last.id)
        method = :put
        confirmation = "About to complete Task \##{e.tasks.last.id}: " +
          "#{e.tasks.last.task_type.name}."
      end

      if @clock[CLOCK_NAMES[e.name]]["state"] == "in"
        ctext = 'Sign out'
        cpath = punch_out_elf_path(e, :username => CLOCK_NAMES[e.name])
        cclass = :punch_out
      else
        ctext = 'Sign in'
        cpath = punch_in_elf_path(e, :username => CLOCK_NAMES[e.name])
        cclass = :punch_in
      end

      @buttons[e.id] = {
        :t => {:text => text, :path => path, 
          :method => method, :confirmation => confirmation},
        :c => {:text => ctext, :path => cpath,
          :method => :post, :class => cclass}}
    end
  end
end
