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
    @tasktypes = TaskType.all.map {|t| [t.name, t.id]}
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
    @tasktypes = TaskType.all.map {|t| [t.name, t.id]}
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes!(params[:task].slice(:quantity, :notes))
    @task.task_type = TaskType.find params[:task][:task_type]
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
    @task.status = 'In Progress'
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
    @task.update_attributes!(:status => 'Completed')
    flash[:notice] = "#{@task.elf.name} completed task \##{@task.id}."
    redirect_to home_path
  end

  def home
    @buttons = Hash.new
    (Elf.where 'name != ""').each do |e|
      if e.tasks.last.name == '' || e.tasks.last.status == 'Completed' 
        text = "#{e.name}. Click to select task."
        path = select_index_elf_path(e)
        method = :get
        confirmation = false
      else
        text = "#{e.name}. Current task: #{e.tasks.last.id}, #{e.tasks.last.name}.  CLICK TO COMPLETE TASK." 
        params[:task_id] = e.tasks.last.id
        path = complete_tasks_path(params.slice(:task_id))
        method = :put
        confirmation = "About to complete Task \##{e.tasks.last.id}: #{e.tasks.last.name}."
      end
      @buttons[e.id] = {:text => text, :path => path, :method => method, :confirmation => confirmation}
    end
  end
end
