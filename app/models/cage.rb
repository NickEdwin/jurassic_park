class Cage < ApplicationRecord
  validates :capacity, numericality: { greater_than_or_equal_to: 1 }, presence: true

  enum power_status: {DOWN: 0, ACTIVE: 1}

  has_many :dinosaurs


  def dino_count
    self.dinosaurs.count
  end

  # has capacity been reached?
  def capacity?
    dino_count == self.capacity
  end

  # is the power off?
  def power_off?
    self.power_status == "DOWN"
  end

  # check for same species of carnivores? OR mixing herbivores and carnivores !
  def carnivores?(dino)
    if self.dinosaurs.any?
      return true if self.dinosaurs.any? { |in_cage| in_cage.food_type != dino[:food_type] } ||
      self.dinosaurs.any? { |in_cage| in_cage.species != dino[:species] }
    end
  end
end
