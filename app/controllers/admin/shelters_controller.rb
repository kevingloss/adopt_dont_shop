class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical

    @app_shelters = Shelter.shelters_with_pending_apps
  end
end
