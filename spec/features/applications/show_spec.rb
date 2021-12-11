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
          name: 'John Doe',
          street: '1234 14th St.',
          city: 'Golden',
          state: 'CO',
          zip: '80209',
          description: 'I will exercise with the pets.',
          )
    end

    it 'contains the name, address, description of the applicant' do
      visit "/application/#{@app.id}"

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

    xit 'contains the names of all the pets on the application as links to their show page' do

    end

    xit 'has the applications status' do

    end
  end
end
