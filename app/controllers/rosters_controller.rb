class RostersController < ApplicationController
  before_action :proper_user, only: [:edit, :update, :destroy]
  before_action :deadline, only: [:edit, :new, :update, :create]
  before_action :limit_players, only: [:update, :create]

  def new
    if !logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    elsif !current_user.roster.nil?
      redirect_to current_user.roster
    else
      @roster = Roster.new
      @players = Player.all
    end
  end

  def create
    @roster = Roster.new(user_id: session[:user_id], final: params[:final])
    @players = Player.all
    params[:players].each { |player| @roster.players << Player.find(player) } unless params[:players].nil?
    if @roster.save
      flash[:success] = "Roster successfully created"
      redirect_to roster_path(@roster)
    else
      flash[:danger] = "Unable to create roster"
      redirect_to new_roster_path
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
    if @roster.save
      flash[:success] = "Roster successfully updated"
      redirect_to roster_path(@roster)
    else
      flash[:danger] = "Unable to update roster"
      redirect_to edit_roster_path(@roster)
    end
  end

  def index
    @rosters = Roster.all
    @rosters = @rosters.sort_by { |roster| -roster.result }
  end

  def destroy
    @roster = Roster.find(params[:id])
    if @roster.destroy
      flash[:success] = "Roster successfully deleted"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Unable to delete roster"
      redirect_to roster_path(@roster)
    end
  end

  private

  def proper_user
    roster = Roster.find_by(id: params[:id])
    unless logged_in? && (current_user == roster.user || admin?)
      flash[:danger] = "Access denied!"
      redirect_back(fallback_location: root_path)
    end
  end

  def deadline
    deadline = Time.new(2018,9,2) # submission deadline example
    if Time.now > deadline
      flash[:danger] = "Roster submission disabled"
      redirect_back(fallback_location: root_path)
    end
  end

  def limit_players
    unless params[:players].keys.size.between?(1,53)
      flash[:danger] = "Players number must be between 1 and 53"
      redirect_back(fallback_location: root_path)
    end
  end
end
