class InvoiceItemsController < ApplicationController
  def new
    @invoice_item = invoice.items.build
  end
  
  def create
    @invoice_item = invoice.items.build invoice_item_params
    if @invoice_item.save
      redirect_to client_invoice_path client, invoice
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if invoice_item.update_attributes invoice_item_params
      redirect_to client_invoice_path client, invoice
    else
      render :edit
    end
  end
  
  def destroy
    flash[:error] = invoice_item.errors[:base].join('. ') if not invoice_item.destroy
    redirect_to client_invoice_path client, invoice
  end
  
  private
  def invoice_item_params
    params[:invoice_item].slice(:name, :description, :amount)
  end
  
  def invoice_item
    @invoice_item ||= invoice.items.find(params[:id])
  end
  helper_method :invoice_item
  
  def client
    @client ||= Client.find(params[:client_id])
  end
  helper_method :client
  
  def invoice
    @invoice ||= client.invoices.find(params[:invoice_id])
  end
  helper_method :invoice
end
