require 'rails_helper'

RSpec.describe 'new application' do
  describe 'from the pet index page' do
    it 'has a link to a new application page' do
      visit "/pets"

      click_link "Start an Application"

      expect(current_path).to eq("/applications/new")
    end

    xit 'has a form to fill in and goes to the new application show page' do

    end
  end
end
