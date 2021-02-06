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

  # first check for food type to avoid mixing herbivores and carnivores
  # then check that if they are a carnivore theyre the same species
  def carnivores?(dino)
    if self.dinosaurs.any?
      self.dinosaurs.any? { |in_cage| in_cage.food_type != dino[:food_type] } ||
      (self.dinosaurs[0].food_type == "Carnivore" && self.dinosaurs.any? { |in_cage| in_cage.species != dino[:species] } )
    end
  end
end
