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
    # @votes = User.find_by(id: params[:id]).votes
  end

  def edit #get
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)

    if @user.save
      redirect_to user_path(@user.id)
    else
      redirect_to edit_user_path(@user.id)
    end
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

