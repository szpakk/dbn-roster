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
    @roster = Roster.new(user_id: session[:user_id], final: params[:final])
    params[:players].each { |player| @roster.players << Player.find(player) } unless params[:players].nil?
    if @roster.save
      flash[:notice] = "Roster succefully created"
      redirect_to roster_path(@roster)
    else
      flash[:warning] = @roster.errors.full_messages.first
      redirect_back(fallback_location: new_roster_path)
    end
  end

  def show
    @final_roster = Roster.final_roster
    @roster = Roster.find_by(id: params[:id])
  end

  def edit
    @roster = Roster.find(params[:id])
    @players = Player.all
  end

  def update
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    params[:players].each { |player| @roster.players << Player.find(player) } unless params[:players].nil?
    @roster.final = params[:final]
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
    unless logged_in? && (current_user == roster.user || admin?)
      flash[:danger] = "Access denied!"
      redirect_back(fallback_location: root_path)
    end
  end
end
