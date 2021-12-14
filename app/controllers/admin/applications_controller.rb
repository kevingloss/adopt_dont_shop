class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    app_pet = ApplicationPet.find(params[:id])
    app_pet.update(pet_status: params[:pet_status])

    redirect_to "/admin/applications/#{app_pet.application_id}"
  end
end
