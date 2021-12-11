require 'rails_helper'

RSpec.describe 'application show page' do
  describe 'when visiting the page' do
    before :each do
      @app = Application.create!(
        name: 'John Doe',
        street: '1234 christmas way',
        city: 'Denver',
        state: 'CO',
        zip: '80209',
        description: 'I love pets.',
        )

      @app_2 = Application.create!(
        name: 'Jane Doe',
        street: '1234 14th St.',
        city: 'Golden',
        state: 'CO',
        zip: '80209',
        description: 'I will exercise with the pets.',
        )

      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @app.pets.push(@pet_1, @pet_2, @pet_3)
    end

    it 'contains the name, address, description of the applicant, and application status' do
      visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.street)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zip)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
      expect(page).to_not have_content(@app_2.name)
      expect(page).to_not have_content(@app_2.description)
    end

    it 'contains the names of all the pets on the application as links to their show page' do
      visit "/applications/#{@app.id}"

      click_link "Clawdia"

      expect(current_path).to eq("/pets/#{@pet_2.id}")
    end
  end
end
