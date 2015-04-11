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
      redirect_to question_path(new_question.id)
    else
      [404, "you lost, so far gone"]
    end
  end

  def update
    question = Question.find_by(id: params[:id])
     if question.update(question_params)
       redirect_to question_path(question.id)
     else
       [404, "you lost, so far gone"]
     end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to questions_path
  end

  private

  def question_params
    # TODO: User ID will eventually become current_user.id. Currently using 1 as an stand in.
    # What merge does is pass along parameters from either "current user" or hidden parameters from forms.
    params.require(:question).permit(:title, :content).merge(user_id: 1)
  end
end
