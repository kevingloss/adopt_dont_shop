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
      @app.pets.push(@pet_1, @pet_2)
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

    it 'has a search for pets by name that shows pets whose name matches the search' do
      visit "/applications/#{@app_2.id}"

      fill_in(:input, with: 'Mr. Spot')
      click_button "Search for pets to add"

      expect(current_path).to eq("/applications/#{@app_2.id}")
      expect(page).to_not have_content(@pet_1.name)
      expect(page).to have_content(@pet_4.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_3.name)
    end

    it 'searches patials and case insensitive' do
      visit "/applications/#{@app_2.id}"

      fill_in(:input, with: 'mr.')
      click_button "Search"

      expect(current_path).to eq("/applications/#{@app_2.id}")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_4.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_3.name)
    end

    describe 'after pets are added to the application' do
      it 'has a section to enter a description and submit the application' do
        visit "/applications/#{@app.id}"

        expect(page).to have_content("Enter description for why you would make a good home for the pet(s):")

        fill_in(:description, with: "I really really like pets.")
        click_button "Submit Application"

        expect(current_path).to eq("/application/#{@app.id}")
        expect(page).to have_content("pending")
        expect(page).to have_content("I really really like pets.")
      end

      xit 'hides the add pets search after the application is pending' do
        visit "/application/#{@app.id}"

        expect(page).to have_content("Enter description for why you would make a good home for the pet(s)")

        fill_in(:description, with: "I really really like pets.")
        click_button "Submit Application"

        expect(page).to_not have_button("Search for pets to add")
      end
    end
  end
end
