require 'rails_helper'

RSpec.describe 'new application' do
  describe 'from the pet index page' do

    it 'has a link to a new application page from pets index' do
      visit "/pets"

      click_link "Start an Application"

      expect(current_path).to eq("/applications/new")
    end

    it 'has a form to fill in and goes to the new application show page' do
      visit "/applications/new"

      fill_in(:name, with: 'John Doe')
      fill_in(:street, with: '1234 christmas way')
      fill_in(:city, with: 'Denver')
      fill_in(:state, with: 'CO')
      fill_in(:zip, with: '80209')
      click_button "Submit Application"

      application = Application.find_by(name: 'John Doe')
      expect(current_path).to eq("/applications/#{application.id}")
    end

    it 'has a message to fill in any missed fields' do
      visit "/applications/new"

      fill_in(:name, with: 'John Doe')
      fill_in(:street, with: '1234 christmas way')
      fill_in(:city, with: 'Denver')
      fill_in(:state, with: 'CO')
      click_button "Submit Application"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Please fill in all fields.")
    end
  end
end
