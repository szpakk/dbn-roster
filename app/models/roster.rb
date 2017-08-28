class Roster < ApplicationRecord
  has_many :selections
  has_many :players, :through => :selections

  validates :players, presence: true, length: { in: 1..53 }
end
