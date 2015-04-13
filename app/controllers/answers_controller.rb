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

     @answer.update(answer_params)
     if @answer.save
      redirect_to @answer.question
     else
      redirect_to edit_answer_path(answer)
     end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy!
    redirect_to '/'
  end

private

  def answer_params
    params.require(:answer).permit(:body, :best, :question_id).merge(user_id: current_user.id)
  end


end
