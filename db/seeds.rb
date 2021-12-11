# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@app = Application.create!(
  name: 'John Doe',
  street: '1234 christmas way',
  city: 'Denver',
  state: 'CO',
  zip: '80209'
  )

@app_2 = Application.create!(
  name: 'Jane Doe',
  street: '1234 14th St.',
  city: 'Golden',
  state: 'CO',
  zip: '80209',
  )

@shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
@pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
@pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
@pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
@app.pets.push(@pet_1, @pet_2, @pet_3)
