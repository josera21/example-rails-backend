class WelcomeController < ApplicationController
  def index
  	@actividades = PublicActivity::Activity.all
  end
end
