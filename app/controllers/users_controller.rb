class UsersController < ApplicationController
  def index  #probably dont need this
  end

  def new  #this is the get
  end

  def create #this is the post
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect to '/signup'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @questions = User.find_by(id: params[:id]).questions
    @answers = User.find_by(id: params[:id]).answers
    @comments = User.find_by(id: params[:id]).comments
    @votes = User.find_by(id: params[:id]).votes
  end

  def edit #get
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    user.update(user_params)
    # move this logic into the application controller
    return render(:edit, status: :bad_request) unless @user.valid?
    redirect_to user
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    redirect_to "/"
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end

