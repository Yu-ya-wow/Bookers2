class UsersController < ApplicationController

  def index
    @user = current_user
    @users=User.all
    @books=@user.books
    @book=Book.new
  end

  def show
    @user = User.find(params[:id])
    @books=@user.books
    @book=Book.new
  end

  def create
    user = User.new(user_params)
    user.save
    redirect_to '/top'
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless @user == current_user
  end
end