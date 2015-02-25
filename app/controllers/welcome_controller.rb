class WelcomeController < ApplicationController
	layout "home", only: :index
	
  def index
  end

  def about
  end
end

