require 'rails_helper'

RSpec.describe ApplicationStatus, type: :model do
  describe 'application status' do
    it 'has attributes' do
      app_status = ApplicationStatus.new(:in_progress)

      expect(app_status.status).to eq(:in_progress)
    end
  end
end
