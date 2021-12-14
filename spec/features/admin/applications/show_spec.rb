require 'rails_helper'

RSpec.describe 'admin application show page' do
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

  it 'shows all the pets that are on an application' do
    visit "admin/applications/#{@app.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_2.name)
  end

  it 'has a button to approve each pet' do
    visit "admin/applications/#{@app.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Approve #{@pet_1.name}")
    end

    within("#pet-#{@pet_3.id}") do
      expect(page).to have_button("Approve #{@pet_3.name}")
    end
  end

  it 'has a button to reject each pet' do
    visit "admin/applications/#{@app.id}"

    within("#pet-#{@pet_1.id}") do
      expect(page).to have_button("Reject #{@pet_1.name}")
    end

    within("#pet-#{@pet_3.id}") do
      expect(page).to have_button("Reject #{@pet_3.name}")
    end
  end

  describe 'when the approval/rejection button is clicked' do
    it 'takes you back to the show page and shows an approved status, and no buttons' do
      visit "admin/applications/#{@app.id}"

      within("#pet-#{@pet_1.id}") do
        click_button("Approve #{@pet_1.name}")

        expect(page).to have_content("#{@pet_1.name} approved for adoption.")
        expect(page).to_not have_button("Approve #{@pet_1.name}")
        expect(page).to_not have_button("Reject #{@pet_1.name}")
      end
    end

    it 'takes you back to the show page and shows a rejected status, and no buttons' do
      visit "admin/applications/#{@app.id}"

      within("#pet-#{@pet_1.id}") do
        click_button("Reject #{@pet_1.name}")

        expect(page).to have_content("#{@pet_1.name} rejected for adoption.")
        expect(page).to_not have_button("Approve #{@pet_1.name}")
        expect(page).to_not have_button("Reject #{@pet_1.name}")
      end
    end
  end
end
