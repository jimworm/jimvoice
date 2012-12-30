require 'spec_helper'

describe InvoiceItemsController do
  let(:client)        { invoice.client }
  let(:invoice)       { invoice_item.invoice }
  let(:invoice_item)  { FactoryGirl.create :invoice_item }
  
  describe "#edit" do
    it "renders the form" do
      get :edit, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id
      response.should render_template :edit
    end
  end
  
  describe "#update" do
    context "with valid inputs" do
      it "updates the item" do
        expect {
          put :update, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id,
            invoice_item: {amount: '123.45'}
        }.to change {
          invoice_item.reload.amount
        }.from(100.0).to(123.45)
      end
      
      it "redirects to the invoice" do
        put :update, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id,
          invoice_item: {amount: '123.45'}
        response.should redirect_to client_invoice_path(client, invoice)
      end
    end
    
    context "with invalid inputs" do
      it "re-renders the form" do
        put :update, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id,
          invoice_item: {amount: ''}
        response.should render_template :edit
      end
    end
  end
  
  describe "#destroy" do
    it "redirects to the invoice's show page" do
      get :destroy, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id
      response.should redirect_to client_invoice_path(client, invoice)
    end
    
    context "when invoice is unsent and unpaid" do
      it "destroys the item" do
        expect {
          delete :destroy, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id
        }.to change {
          invoice.items.count
        }.by -1
      end
    end
    
    context "when invoice is sent" do
      before { invoice.update_attribute :sent, true}
      
      it "doesn't destroy and shows the error" do
        expect {
          get :destroy, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id
          flash[:error].should include 'Invoice has already been issued'
        }.not_to change { invoice.items.count }
      end
    end
    
    context "when invoice is paid" do
      before { invoice.update_attribute :paid, true}
    
      it "doesn't destroy and shows the error" do
        expect {
          get :destroy, client_id: client.id, invoice_id: invoice.id, id: invoice_item.id
          flash[:error].should include 'Invoice has already been issued'
        }.not_to change { invoice.items.count }
      end
    end
  end
  
  
end
