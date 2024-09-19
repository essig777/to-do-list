class TasksController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy list_comment remove_image add_user_to_task]
  before_action :authorize_admin!

  def index
    if @admin
      if !params[:situation].nil?
        @tasks = Task.situation_filter(params[:situation])
      elsif !params[:user_id].nil?
        @tasks = Task.user_filter(params[:user_id])
      else
        @tasks = Task.all
      end
      render json: @tasks
    else
      @tasks = Task.user_filter(current_user.id)
      render json: @tasks
    end
  end
  

  def show
    render json: @task
  end

  def list_comment
    render json: @task.comment
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.image.attach(params[:task][:image])
    if @task.save
      render :show, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render :show, status: :ok, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def remove_image
    return if @task.image.nil?
    @task.image.purge

    if !@task.image.attached?
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def add_user_to_task
    if @task.update(user_id: params[:user_id])
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
  end

  private
    def set_task
      if @admin
        @task = Task.find_by(id: params[:id])
      else
        @task = current_user.tasks.find(params[:id])
      end
    end

    def task_params
      params.require(:task).permit(:title, :description, :situation, :estimated_time, :image, :user_id)
    end

    def authorize_admin!
      @admin = current_user.is_admin
    end
end
