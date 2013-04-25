class TasksController < ApplicationController
  def index
    @tasks = Task.where 'name != ""'
  end

  def show
    @task = Task.find(params[:id]) # look up task by passed id
    # will render app/views/tasks/show.html.haml by default
  end

  def new
    # will render app/views/tasks/new.html.haml by default
  end

  def create
    params[:task][:status] = 'Posted'
    @task = Task.create!(params[:task])
    @task.elf = (Elf.where 'name = ""').first
    @task.save
    flash[:notice] = "Task #{@task.id} was successfully created."
    redirect_to tasks_path
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes!(params[:task])
    flash[:notice] = "Task \##{@task.id} was successfully updated."
    redirect_to task_path(@task)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "Task \##{@task.id}:#{@task.name} deleted."
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
