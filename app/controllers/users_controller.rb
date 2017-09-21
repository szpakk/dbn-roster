class UsersController < ApplicationController
  before_action :logged_in_admin, except: [:new, :create, :show]
  before_action :proper_user, only: [:show]


  def index
    @users = User.all
  end

  def new
    if logged_in?
      flash[:warning] = "Already logged in"
      redirect_to current_user
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Sign up complete!"
      redirect_to @user
    else
      flash[:danger] = "Unable to create user!"
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User deleted successfully!"
    else
      flash[:warning] = "Unable to delete user!"
    end
    redirect_to users_path
  end

  def show
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    user = User.find_by(id: params[:id])
    if user == current_user || !admin?
      flash[:danger] = "Access denied!"
      redirect_to edit_user_path(user)
    else
      user.update_attribute(:admin, params[:admin])
      flash[:success] = "Successfully updated user!"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def proper_user
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      flash[:danger] = "Access denied!"
      redirect_to root_path
    end
  end
end
