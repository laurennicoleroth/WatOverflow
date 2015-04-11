class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
    render partial: "new", layout: false, locals: { comment: @comment }
  end

  def create
    @comment = Comment.create!(comment_params)
    if @comment.valid?
      render partial: "comment", layout: false, locals: { comment: @comment }
    else
      @errors = @comment.errors.full_messages
      render partial: "comment", layout: false, locals: { comment: @comment }
    end
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
    params.require(:comment).permit(:body, :user_id, :comment)
  end
end
