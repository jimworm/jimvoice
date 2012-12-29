class InvoicesController < ApplicationController
  def index
    @invoices = client.invoices.order('created_at DESC')
  end
  
  def new
    @invoice = client.invoices.build
  end
  
  def create
    @invoice = client.invoices.build
    @invoice.currency = params[:invoice][:currency]
    if @invoice.save
      redirect_to client_invoice_path(client, @invoice)
    else
      render :new
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
  
  private
  def client
    @client ||= Client.find(params[:client_id])
  end
  helper_method :client
end