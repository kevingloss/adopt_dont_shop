class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:add_pet] && @application.status == "in_progress"
      @pets = Pet.search(params[:add_pet])
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
      # the render below seems to direct me to the applications/index for some reason, why?
      # render :new
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(app_params)
    application.pending!

    redirect_to "/applications/#{application.id}"
  end

  private
  def app_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end
