class Roster < ApplicationRecord
  has_many :selections
  has_many :players, :through => :selections
  belongs_to :user

  validates :players, presence: true, length: { in: 1..53 }
end
