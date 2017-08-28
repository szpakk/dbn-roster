class RostersController < ApplicationController
  def new
    @players = Player.all
  end

  def create
    @roster = Roster.new
    params[:players].each { |player| @roster.players << Player.find(player) }
    @roster.save
  end

end
