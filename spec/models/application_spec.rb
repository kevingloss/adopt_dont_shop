require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  it 'will set the description by default' do
    app = Application.create!(
      name: 'John Doe',
      street: '1234 christmas way',
      city: 'Denver',
      state: 'CO',
      zip: '80209'
      )

      expect(app.description).to eq("Awaiting Input")
  end
end
