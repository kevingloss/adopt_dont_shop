class Admin::ApplicationPetsController < ApplicationsController
  def update
    app_pet = ApplicationPet.find(params[:id])
    app_pet.update(pet_status: params[:pet_status])

    redirect_to "/admin/applications/#{app_pet.application_id}"
  end
end
