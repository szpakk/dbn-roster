class Roster < ApplicationRecord
  has_many :selections, dependent: :destroy
  has_many :players, through: :selections
  belongs_to :user
  validate :is_there_final?
  validate :player_limit

  def self.final_roster
    Roster.find_by(final: true)
  end

  def result
    return 0.0 if Roster.final_roster.nil?
    count = 0.0
    final_roster_size = Roster.final_roster.players.size / 100.0
    roster_size = self.players.size / 100.0
    self.players.each { |player| count += 1 if Roster.final_roster.players.include?(player) }
    result = roster_size < final_roster_size ? count / final_roster_size : count / roster_size
  end

  private

  def is_there_final?
    errors.add(:final, 'roster exists') if final == true && !Roster.final_roster.nil?
  end

  def player_limit
    errors.add(:players, 'number must be between 1 and 53') unless players.size.between?(1,53) && selections.size.between?(1,53)
  end
end
