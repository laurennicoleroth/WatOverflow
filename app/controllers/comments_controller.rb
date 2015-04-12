class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
    render partial: "comment", layout: false, locals: { comment: @comment }
  end

  def new
    @comment = Comment.new
    render partial: "new", layout: false, locals: { comment: @comment }
  end

  def create
    flash[:notice] = "Thanks for your comment!"
    @comment = Comment.create!(comment_params)
    # render partial: "comment", layout: false, locals: { comment: @comment }

    if @comment.valid?
      redirect_to question_path(@comment.commentable_id)
    else
      @errors = @comment.errors.full_messages
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render partial: "comment", layout: false, locals: { comment: @comment }
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment
      @comment.destroy
      flash[:notice] = "Comment Destroyed"
      redirect_to '/comments'
    else
      redirect_to :action => 'show'
    end
  end

  def upvote
  end

  def downvote
  end

private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_id, :commentable_type)
  end
end
