class TasksController < ApplicationController
  ELVES = { 1 => 'Sawyer Bernath', 2 => 'Kristin Yen', 3 => 'Logan Priess',
    4 => 'Keegan Ridgley', 5 => 'Karl Stokely', 6 => 'Chris Borke' }

  def index
    @tasks = Task.all
    @elves = ELVES
  end

  def show
    @task = Task.find(params[:id]) # look up task by passed id
    # will render app/views/tasks/show.html.haml by default
  end

  def new
    # will render app/views/tasks/new.html.haml by default
  end

  def create
    Task.send(:attr_accessible, :name, :quantity, :notes, :status)
    params[:task][:status] = 'Posted'
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
    @elves = ELVES.invert
  end

  def select
    @task = Task.find params[:id]
    Task.send(:attr_accessible, :status, :elf)
    @task.update_attributes!(:status => 'In Progress', :elf => params[:elf])
    flash[:notice] = "Task \##{@task.id} was taken."
    redirect_to select_index_tasks_path
  end

  def complete_index
    @iptasks = Task.select {|t| t.status == 'In Progress'}
    @elves = ELVES
  end

  def complete
    @task = Task.find params[:id]
    Task.send(:attr_accessible, :status)
    @task.update_attributes!(:status => 'Completed')
    flash[:notice] = "#{@task.elf} completed task \##{@task.id}."
    redirect_to tasks_path
  end
end
