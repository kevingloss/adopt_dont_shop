require 'rails_helper'

RSpec.describe 'create pets on application' do
  before :each do
    @app = Application.create!(
      name: 'John Doe',
      street: '1234 christmas way',
      city: 'Denver',
      state: 'CO',
      zip: '80209',
      description: 'Great with animals.'
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
    @pet_4 = @shelter_1.pets.create(name: 'Mr. Spot', breed: 'ragdoll', age: 3, adoptable: true)
    @app.pets.push(@pet_1, @pet_2, @pet_3)
  end

  describe 'from the application show page' do
    it 'can add pets to the application with a button' do
      visit "/applications/#{@app_2.id}"
      fill_in(:pet_name, with: 'Mr.')
      click_button "Search"

      within("#pet-#{@pet_4.id}") do
        click_button "Adopt this Pet"
      end

      expect(current_path).to eq("/applications/#{@app_2.id}")
      expect(page).to have_content(@pet_4.name)
      expect(page).to_not have_content(@pet_1.name)
    end
  end
end
