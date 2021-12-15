# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ApplicationPet.destroy_all
# Application.destroy_all
# Shelter.destroy_all
# Pet.destroy_all

@app = Application.where(
  name: 'John Doe',
  street: '1234 christmas way',
  city: 'Denver',
  state: 'CO',
  zip: '80209'
  ).first_or_create

@app_2 = Application.where(
  name: 'Jane Doe',
  street: '1234 14th St.',
  city: 'Golden',
  state: 'CO',
  zip: '80209',
).first_or_create


@shelter_1 = Shelter.where(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9).first_or_create
@shelter_2 = Shelter.where(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5).first_or_create
@shelter_3 = Shelter.where(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10).first_or_create

@pet_1 = @shelter_1.pets.where(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true).first_or_create
@pet_2 = @shelter_1.pets.where(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true).first_or_create
@pet_3 = @shelter_1.pets.where(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false).first_or_create
@pet_4 = @shelter_3.pets.where(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true).first_or_create

@app.pets.push(@pet_1, @pet_2)
@app_2.pets.push(@pet_4)
