class Player < ApplicationRecord
  def self.positions
    %w[QB RB FB WR TE OL DL LB CB S K P LS]
  end
end
