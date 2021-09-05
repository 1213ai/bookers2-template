class UsersController < ApplicationController
  before_action :authenticate_user!, expect: [:top, :about]
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     @user = current_user
     redirect_to user_path(@user.id)
     flash[:notice] = "You have updated user successfully."
    else
      render 'edit'
    end
  end

  # def destroy
    # @user = User.find(1)
    # @user.destroy
  # end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)

  end

  def ensure_correct_user
    user = User.find(params[:id])
    unless user == current_user
     redirect_to user_path(current_user)
    end
  end

end
