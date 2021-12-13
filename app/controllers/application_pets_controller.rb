class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    @application.pets.push(pet)

    redirect_to "/applications/#{@application.id}"
  end
end
