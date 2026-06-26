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
  end

  def update
  end

  def destroy
  end
end
