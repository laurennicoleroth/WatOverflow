class UsersController < ApplicationController

  def index do #probably dont need this
  end

  def new do #this is the get
  end

  def create do #this is the post
    @user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect to '/signup'
    end
  end


private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end

