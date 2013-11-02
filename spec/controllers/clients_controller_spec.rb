require 'spec_helper'

describe ClientsController do
  let(:client1) { FactoryGirl.create :client, name: 'Dooby Doo Corp', email: 'bing.crosby@example.com' }
  let(:client2) { FactoryGirl.create :client, name: 'Shooby Dua Ltd' }
  let(:valid_client) { FactoryGirl.build :client, name: 'Doowop', email: 'doowop@example.com' }
  let(:invalid_client) { FactoryGirl.build :client, name: 'Boobity', email: 'notemail' }
  
  describe "#index" do
    render_views
    
    before do
      client1
      client2
    end
    
    it "shows the client index,
        links to the client pages,
        and links to the clients' invoice index pages" do
      get :index
      response.body.should include 'Dooby Doo Corp',
                                   'Shooby Dua Ltd'
      response.body.should include "href=\"#{client_path(client1)}\"",
                                   "href=\"#{client_path(client2)}\""
      response.body.should include "href=\"#{client_invoices_path(client1)}\"",
                                   "href=\"#{client_invoices_path(client2)}\""
    end
  end
  
  describe "#show" do
    render_views
    
    it "shows the correct information" do
      get :show, id: client1.id
      response.body.should include 'Email: bing.crosby@example.com'
    end
  end
  
  describe "#new" do
    it "renders a new client form" do
      get :new
      response.should render_template 'clients/new'
    end
  end
  
  describe "#create" do
    context "with valid info" do
      it "creates a new client" do
        expect { post :create, client: valid_client.attributes.slice('name', 'email') }.to change(Client, :count).by(1)
      end
    
      it "redirects to the client's show page" do
        post :create, client: valid_client.attributes.slice('name', 'email')
        response.should redirect_to client_path(Client.last)
      end
    end
    
    context "with invalid info" do
      it "doesn't create a client" do
        expect { post :create, client: invalid_client.attributes.slice('name', 'email') }.not_to change(Client, :count)
      end
      
      it "renders the new page again" do
        post :create, client: invalid_client.attributes.slice('name', 'email')
        response.should render_template 'clients/new'
      end
    end
  end
  
  describe "#edit" do
    before { client1 }

    it "renders the edit client form" do
      get :edit, id: client1.id
      response.should render_template 'clients/edit'
    end
  end
  
  describe "#update" do
    before { client1 }
    
    context "with valid input" do
      it "updates the client" do
        post :update, id: client1.id, client: valid_client.attributes.slice('name', 'email')
        client1.reload
        client1.name.should == valid_client.name
        client1.email.should == valid_client.email
      end
    end
    
    context "with invalid input" do
      it "does not update the client" do
        post :update, id: client1.id, client: invalid_client.attributes.slice('name', 'email')
        client1.reload
        client1.name.should_not == invalid_client.name
        client1.email.should_not == invalid_client.email
      end
    end
  end
end
