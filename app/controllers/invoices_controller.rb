class InvoicesController < ApplicationController
  def index
    @invoices = client.invoices.order('created_at DESC')
  end
  
  def new
    @invoice = client.invoices.build
  end
  
  def create
    @invoice = client.invoices.build invoice_params
    if @invoice.save
      redirect_to [client, @invoice]
    else
      render :new
    end
  end

  def show
  end
  
  def issue
    success_message = "Invoice successfully #{'re-' if invoice.issued?}issued"
    invoice.issue!
    flash[:notice] = success_message
  rescue => e
    flash[:error] = e.message
  ensure
    redirect_to [client, invoice]
  end
  
  def pay
    invoice.update_attribute :paid, true
    redirect_to [client, invoice]
  end
  
  private
  def invoice_params
    params[:invoice].slice(:currency)
  end
  
  def invoice
    @invoice ||= client.invoices.find(params[:id])
  end
  helper_method :invoice
  
  def client
    @client ||= Client.find(params[:client_id])
  end
  helper_method :client
end
