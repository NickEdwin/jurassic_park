class Cage < ApplicationRecord
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }, presence: true

  enum power_status: {DOWN: 0, ACTIVE: 1}

  has_many :dinosaurs
end
