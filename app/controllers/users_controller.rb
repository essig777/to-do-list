class UsersController < ApplicationController
  before_action :authenticate_user!, except: :register
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :current_user_is_admin, except: :register
  

  def register
    @user = User.new(register_params)
    if @user.save
      render :show, json: @user, status: :created 
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created 
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :is_admin)
    end

    def register_params
      params.permit(:email, :password, :password_confirmation, :is_admin)
    end

    def current_user_is_admin
      render json: {}, status: 403 unless current_user.is_admin
    end
end
