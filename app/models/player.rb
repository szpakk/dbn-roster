class Player < ApplicationRecord
  validates :name, presence: true, length: { in: 2..50 },
                                   uniqueness: { case_sensitive: false }
  validates :position, presence: true, length: { minimum: 1 },
                                   inclusion: { in: %w[QB RB FB WR TE OL DL LB CB S K P LS] }

  def self.positions
    %w[QB RB FB WR TE OL DL LB CB S K P LS]
  end
end
