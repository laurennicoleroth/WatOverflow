class AnswersController < ActionController::Base

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

    # TODO: ADD USER AUTH
    # @answer.user_id = session[:user_id]

    if @answer.save
      redirect_to @answer
    else
      redirect_to new_answer_path
    end
  end

def edit
    @answer = Answer.find(params[:id])
  end

  def update
     @answer = Answer.find(params[:id])

    # TODO: ADD USER AUTH
    # @answer.user_id = session[:user_id]

     @answer.update(answer_params)
     if @answer.save
      redirect_to @answer
     else
      redirect_to edit_answer_path
     end
  end

private

  def answer_params
    #TODO: USER ID WILL EVENTUALLY BECOME CURRENT_USER
    params.require(:answer).permit(:body, :best).merge(user_id: 1, question_id: params[:question_id])
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy!
    redirect_to '/'
  end

end