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
    final_roster_size = Roster.final_roster.players.size / 100.0
    roster_size = self.players.size / 100.0
    self.players.each { |player| count += 1 if Roster.final_roster.players.include?(player) }
    result = roster_size < final_roster_size ? count / final_roster_size : count / roster_size
  end

  def is_there_final?
    errors.add(:final, 'roster exists') if final == true && !Roster.final_roster.nil?
  end
end
