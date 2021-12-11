class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  private
  def app_params
    params.permit(:name, :street, :city, :state, :zip, :description, :status)
  end
end
