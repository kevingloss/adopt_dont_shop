class ApplicationPet < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  enum pet_status: { pending: 0, rejected: 1, approved: 2}
end
