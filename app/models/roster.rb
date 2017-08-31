class Roster < ApplicationRecord
  has_many :selections
  has_many :players, :through => :selections
  belongs_to :user

  validates :players, presence: true, length: { in: 1..53 }
  validate :is_there_final?

  def self.final_roster
    Roster.find_by(final: true)
  end

  def is_there_final?
    errors.add(:rosters, 'Final roster exists') unless final == false || Roster.final_roster.nil?
  end
end
