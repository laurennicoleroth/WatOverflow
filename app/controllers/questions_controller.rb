# TODO: Change to rails controller
class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find_by(id: params[:id])
  end

  def new
    @new_question = Question.new
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def create
    new_question = Question.new(question_params)
    if new_question.save!
      redirect_to "/questions/#{new_question.id}"
    else
      [404]
    end
  end

  def update
    question = Question.find_by(id: params[:id])
     if question.update(question_params)
       redirect_to "/"
     else
       [404]
     end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to "/"
  end

  private

  def question_params
    params.require(:question).permit(:title, :content).merge(user_id: current_user.id)
  end
end
