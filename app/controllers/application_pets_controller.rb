class ApplicationPetsController < ApplicationController
  def create
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])

    if application.pets.include?(pet) == false
      # ApplicationPet.create(application: application, pet: pet)
      application.pets.push(pet)
    end

    redirect_to "/applications/#{application.id}"
  end
end
