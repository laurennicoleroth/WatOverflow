class AnswersController < ActionController::Base

# Add in voting logic
# Add in comments logic
  def index
    @answers = Answer.all
  end



private

  def answer_params
    params.require(:answer).permit(:body, :best, :user_id, :question_id)
  end

end