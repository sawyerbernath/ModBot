class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id]) # look up task by passed id
    # will render app/views/tasks/show.html.haml by default
  end

  def new
    # will render app/views/tasks/new.html.haml by default
  end

  def create
    Task.send(:attr_accessible, :name, :quantity, :notes, :status, :elf_id)
    params[:task][:status] = 'Posted'
    params[:task][:elf_id] = (Elf.where 'name = ""').first.id
    @task = Task.create!(params[:task])
    flash[:notice] = "Task #{@task.id} was successfully created."
    redirect_to tasks_path
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    Task.send(:attr_accessible, :name, :quantity, :notes, :status)
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
    @elves = Elf.all.map {|e| [e.name, e.id]}
  end

  def select
    @task = Task.find params[:id]
    @elf = Elf.find params[:elf]
    @task.status = 'In Progress'
    @elf.tasks << @task
    flash[:notice] = "Task \##{@task.id} was taken."
    redirect_to select_index_tasks_path
  end

  def complete_index
    @iptasks = Task.select {|t| t.status == 'In Progress'}
  end

  def complete
    @task = Task.find params[:id]
    Task.send(:attr_accessible, :status)
    @task.update_attributes!(:status => 'Completed')
    flash[:notice] = "#{@task.elf.name} completed task \##{@task.id}."
    redirect_to tasks_path
  end

  def home
    @task = Task.last
    @elves = Elf.all
    @elves.each do |e|
      if e.task_id.nil?
        e.task_id = 0
      end
    end
  end
end
