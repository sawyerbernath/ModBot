class TasksController < ApplicationController
  ELVES = [['Sawyer Bernath', 1], ['Kristin Yen', 2], ['Logan Priess', 3],
           ['Keegan Ridgley', 4], ['Karl Stokely', 5], ['Chris Borke', 6]]

  def index
    @tasks = Task.all
  end

  def show
    id = params[:id] # retrieve task ID from URI route
    @task = Task.find(id) # look up task by unique ID
    # will render app/views/tasks/show.html.haml by default
  end

  def new
    # will render app/views/tasks/new.html.haml by defaul
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

  def select
    @ptasks = Task.select {|t| t.status == 'Posted'}
    @elves = ELVES
  end
end
