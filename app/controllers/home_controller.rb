class HomeController < ApplicationController
  def index
    redirect_to clients_path
  end
end
