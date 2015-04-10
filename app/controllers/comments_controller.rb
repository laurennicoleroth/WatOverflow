class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def upvote
  end

  def downvote
  end

private

  def comment_params
    params.require(:comment).permit(:body, :user, :commentable)
  end
end
