class ClientsController < ApplicationController
  def index
    @clients = Client.order(:name).all
  end
  
  def show
  end
  
  private
  def client
    @client ||= Client.find params[:id]
  end
  helper_method :client
end
