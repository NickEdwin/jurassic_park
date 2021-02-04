class Dinosaur < ApplicationRecord
  validates :name, presence: true
  validates :species, presence: true
  validates :food_type, presence: true

  belongs_to :cage
end
