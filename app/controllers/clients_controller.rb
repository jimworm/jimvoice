class ClientsController < ApplicationController
  def index
    @clients = Client.order(:name).all
  end
end
