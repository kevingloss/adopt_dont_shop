class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates_presence_of(:name, :street, :city, :state, :zip, :description, :status)
  enum status: { in_progress: 'In Progress', pending: 'Pending', accepted: 'Accepted', rejected: 'Rejected'}

  def status
    @status = status
  end
end
