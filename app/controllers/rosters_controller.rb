class RostersController < ApplicationController
  before_action :proper_user, only: [:edit, :update, :destroy]
  before_action :deadline, only: [:edit, :new, :update, :create]

  def new
    if !logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    elsif !current_user.roster.nil?
      redirect_to current_user.roster
    else
      @roster = Roster.new
      session[:players].each { |player| @roster.players << Player.find(player) } if session[:players]
      @players = Player.all
    end
  end

  def create
    @roster = Roster.new(user_id: session[:user_id], final: params[:final])
    @players = Player.all
    params[:players].each { |player| @roster.players << Player.find(player) } unless params[:players].nil?
    if @roster.save
      flash[:success] = "Roster succefully created"
      redirect_to roster_path(@roster)
    else
      flash[:danger] = "Number of players must be between 1 and 53"
      session[:players] = params[:players]
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
    @roster.save
    redirect_to roster_path(@roster)
  end

  def index
    admin = User.find_by(:admin => true)
    @rosters = Roster.where.not(:user_id => admin.id)
    @rosters = @rosters.sort_by { |roster| -roster.result }
  end

  def destroy
    @roster = Roster.find(params[:id])
    @roster.selections.delete_all
    if @roster.delete
      flash[:success] = "Roster successfully deleted"
      redirect_to user_path(current_user)
    else
      flash[:danger] = "Unable to delete roster"
      render roster_path(@roster)
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
    deadline = Time.new(2018,9,2)
    if Time.now > deadline
      flash[:danger] = "Roster creation/modification disabled"
      redirect_back(fallback_location: root_path)
    end
  end
end
