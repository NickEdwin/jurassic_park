# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@cage1 = Cage.create(
  capacity: 2
)

@dino1 = Dinosaur.create(
  name: "Scratchy",
  species: "Velociraptor",
  food_type: "Carnivore",
  cage_id: @cage1.id
)
@dino2 = Dinosaur.create(
  name: "Big Claw",
  species: "Velociraptor",
  food_type: "Carnivore",
  cage_id: @cage1.id
)
