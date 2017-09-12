class UsersController < ApplicationController
  before_action :logged_in_admin, except: [:new, :create, :show]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Sign up complete!"
      redirect_to new_roster_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User deleted succesfully"
    else
      flash[:warning] = "Something went wrong"
    end
    redirect_to users_path
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless @user == current_user
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    user = User.find_by(id: params[:id])
    if user == current_user || !admin?
      flash[:danger] = "Access denied"
      redirect_to edit_user_path(user)
    else
      user.update_attribute(:admin, params[:admin])
      flash[:success] = "succesfully updated user"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def logged_in_admin
    redirect_to root_path unless admin?
  end
end
