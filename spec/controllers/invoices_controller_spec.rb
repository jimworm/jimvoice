require 'spec_helper'

describe InvoicesController do
  let(:client)    { invoice1.client }
  let(:invoice1)  { FactoryGirl.create :invoice, currency: 'isk' }
  let(:invoice2)  { FactoryGirl.create :invoice, client: client }
  
  let(:other_client)  { other_invoice.client }
  let(:other_invoice) { FactoryGirl.create :invoice, sent: true }
  
  describe "#index" do
    before do
      invoice2
      other_invoice
    end
    
    it "shows the client's invoices and not another client's" do
      get :index, client_id: client.id
      assigns(:client).should == client
      assigns(:invoices).should include invoice1, invoice2
      assigns(:invoices).should_not include other_invoice
    end
  end
  
  describe "#new" do
    render_views
    
    it "displays the company name" do
      get :new, client_id: client.id
      response.body.should include "#{client.name}"
    end
  end
  
  describe "#create" do
    context "when valid" do
      it "creates an invoice" do
        expect {
          post :create, client_id: client, invoice: {currency: 'gbp'}
          assigns(:invoice).should be_persisted
        }.to change {
          client.invoices.count
        }.by 1
      end
      
      it "redirects to the new invoice" do
        post :create, client_id: client, invoice: {currency: 'gbp'}
        response.should redirect_to client_invoice_path(client, assigns(:invoice))
      end
    end
    
    context "when invalid" do
      it "renders the form again" do
        post :create, client_id: client, invoice: {currency: ''}
        response.should render_template 'invoices/new'
      end
    end
  end
  
  describe "#show" do
    render_views
    
    it "displays the total" do
      Invoice.any_instance.stub(:total).and_return(100.0)
      
      get :show, client_id: client.id, id: invoice1.id
      response.body.should include '100.0 ISK'
    end
  end
end
