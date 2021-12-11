class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  enum status: { in_progress: 'In Progress', pending: 'Pending', accepted: 'Accepted', rejected: 'Rejected'}
  validates_presence_of(:name, :street, :city, :state, :zip, :description, :status)
end
