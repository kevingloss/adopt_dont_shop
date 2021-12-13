class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name] && @application.status == "in_progress"
      @pets = Pet.search(params[:pet_name])
    else
      @pets = []
    end
  end

  def new
  end

  def create
    application = Application.create(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill in all fields."
      redirect_to "/applications/new"
    end
  end

  private
  def app_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end
