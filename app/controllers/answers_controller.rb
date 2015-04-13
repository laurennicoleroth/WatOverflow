 class AnswersController < ApplicationController

# Add in voting logic
# Add in comments logic
  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = session[:user_id]

    if @answer.save
      render partial: 'show', locals: {answer: @answer}
    else
      redirect_to @answer.question
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
     @answer = Answer.find(params[:id])
     @answer.user_id = session[:user_id]

     @answer.update(answer_params)
     if @answer.save
      redirect_to @answer.question
     else
      redirect_to edit_answer_path(answer)
     end
  end

private

  def answer_params
    params.require(:answer).permit(:body, :best, :question_id).merge(user_id: session[:user_id])
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy!
    redirect_to '/'
  end

end
