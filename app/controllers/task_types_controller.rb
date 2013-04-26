class TaskTypesController < ApplicationController
  def index
    @task_types = TaskType.all
  end

  def new
  end

  def create
    @task_type = TaskType.create!(params[:task_type])
    flash[:notice] = "Task type #{@task_type.name} was successfully created."
    redirect_to task_types_path
  end

  def show
    @task_type = TaskType.find params[:id]
  end

  def edit
    @task_type = TaskType.find params[:id]
  end

  def update
    @task_type = TaskType.find params[:id]
    @task_type.update_attributes! params[:task_type]
    flash[:notice] = "Task type #{@task_type.id}: #{@task_type.name} was successfully updated."
    redirect_to task_type_path @task_type
  end

  def destroy
    @task_type = TaskType.find params[:id]
    @task_type.destroy
    flash[:notice] = "Task type #{@task_type.name} deleted."
    redirect_to task_types_path
  end
end
