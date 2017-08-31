class RostersController < ApplicationController
  before_action :proper_user, only: [:edit, :update, :destroy]
  def new
    if !logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    elsif !current_user.roster.nil?
      redirect_to current_user.roster
    else 
      @players = Player.all
    end
  end

  def create
    @roster = Roster.new
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.user_id = session[:user_id]
    @roster.save
    redirect_to roster_path(@roster)
  end

  def show
    @roster = Roster.find_by(id: params[:id])
  end

  def edit
    @roster = Roster.find(params[:id])
    @players = Player.all
  end

  def update
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.save
    redirect_to roster_path(@roster)
  end

  def index
    admin = User.find_by(:admin => true)
    @rosters = Roster.where.not(:user_id => admin.id)
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    @roster.delete
    redirect_to new_roster_path
  end

  private

  def proper_user
    roster = Roster.find_by(id: params[:id])
    unless logged_in? && current_user == roster.user
      flash[:danger] = "Access denied!"
      redirect_back(fallback_location: root_path)
    end
  end
end
