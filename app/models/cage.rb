class Cage < ApplicationRecord
  validates :capacity, presence: true

  enum role: {DOWN: 0, ACTIVE: 1}

  has_many :dinosaurs
end
