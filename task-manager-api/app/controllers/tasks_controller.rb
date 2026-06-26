class TasksController < ApplicationController
  def index
    tasks = Rails.cache.fetch("tasks:user_#{@current_user.id}") do 
      @current_user.tasks.to_a
    end
    render json: tasks
  end

  def show
    task = @current_user.tasks.find(params[:id])
    render json: task
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Task not found'}, status: :not_found

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
    task = @current_user.tasks.find(params[:id])
    if task.update(task_params)
      Rails.cache.delete("tasks:user_#{@current_user.id}")
      render json: task, status: :ok
    else
      render json: task.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
      render json: {error: 'Task not found'}, status: :not_found
  end

  def destroy
    task = @current_user.tasks.find(params[:id])
    task.destroy
    Rails.cache.delete("tasks:user_#{@current_user.id}")
    head :no_content
  rescue ActiveRecord::RecordNotFound
    render json: {error: 'Task not found'}, status: :not_found
  end

  private
  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end

end
