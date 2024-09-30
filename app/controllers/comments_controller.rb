class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy show_comments ]
  before_action :authenticate_user!
  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    render json: @comment
  end

  def edit
  end

  def show_comments
    render json: @comment.comment
  end

  def create
  @comment = Comment.new(comment_params)
    if @comment.save
      render :show, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render :show, status: :ok, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:description, :commentable_type, :commentable_id, :user_id)
    end
end
