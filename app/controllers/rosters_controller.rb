class RostersController < ApplicationController
  def new
    @players = Player.all
  end
end
