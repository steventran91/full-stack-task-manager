class TasksController < ApplicationController
  def index
    tasks = Rails.cache.fetch("tasks:user_#{@current_user.id}") do 
      @current_user.tasks.to_a
    end
    render json: tasks
  end

  def show
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      Rails.cache.delete("tasks:user_#{@current_user.id}")
      render json: task, status: :created 
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end

end
