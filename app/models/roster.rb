class Roster < ApplicationRecord
  has_many :selections
  has_many :players, :through => :selections
  belongs_to :user

  validates :players, presence: true, length: { in: 1..53 }
  validate :is_there_final?

  def self.final_roster
    Roster.find_by(final: true)
  end

  def result
    return 0.0 if Roster.final_roster.nil?
    count = 0.0
    self.players.each { |player| count += 1 if Roster.final_roster.players.include?(player) }
    count / 0.53
  end

  def is_there_final?
    errors.add(:rosters, 'Final roster exists') unless final == false || Roster.final_roster.nil?
  end
end
