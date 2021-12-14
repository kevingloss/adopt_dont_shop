require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @app = Application.create!(
      name: 'John Doe',
      street: '1234 christmas way',
      city: 'Denver',
      state: 'CO',
      zip: '80209',
      )
    @app.pets.push(@pet_1, @pet_3)
    @app.pending!
  end

  describe 'on the index page' do
    it 'lists all the shelters in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it 'lists all the shelters with pending pet applications' do
      visit '/admin/shelters'

      within("#shelters_with_pending_apps") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_3.name)
        expect(page).to_not have_content(@shelter_2.name)
      end
    end
  end
end
