class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { in_progress: 0, pending: 1, accepted: 2, rejected: 3}
  validates_presence_of(:name, :street, :city, :state, :zip, :description, :status)
end
