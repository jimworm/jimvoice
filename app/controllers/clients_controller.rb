class ClientsController < ApplicationController
  def index
    @clients = Client.order(:name).all
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new params[:client]
    if client.save
      redirect_to client_path(client)
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if client.update_attributes params[:client]
      redirect_to client_path(client)
    else
      render :edit
    end
  end
  
  private
  def client
    @client ||= Client.find params[:id]
  rescue ActiveRecord::RecordNotFound
    not_found "No client with id=#{params[:id]} found"
  end
  helper_method :client
end
