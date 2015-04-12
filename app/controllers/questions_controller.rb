class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @recent_questions = Question.find_most_recent
    @highest_voted_questions = Question.find_highest_voted
  end

  def show
    # Answer.new is needed here because when using partial (See in 'views/questions/show'), you need to pass in the parameters for the partial to work. We can take out the answers controller's 'def new' at this point.
    @question = Question.find_by(id: params[:id])
    @username = User.find(@question.user_id).name.downcase.split('').join.gsub(' ','')
    @answers = @question.answers
    @answer = Answer.new
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
    # What merge does is pass along parameters from either "current user" or hidden parameters from forms.
    params.require(:question).permit(:title, :content).merge(user_id: current_user.id)
  end
end
