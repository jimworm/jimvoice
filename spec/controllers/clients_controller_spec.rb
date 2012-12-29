require 'spec_helper'

describe ClientsController do
  let!(:client1) { FactoryGirl.create :client, name: 'Dooby Doo Corp' }
  let!(:client2) { FactoryGirl.create :client, name: 'Shooby Dua Ltd' }
  
  describe "#index" do
    render_views
    
    it "shows the client index" do
      get :index
      response.body.should include 'Dooby Doo Corp'
      response.body.should include 'Shooby Dua Ltd'
    end
    
    it "links to the clients' invoice index pages" do
      get :index
      response.body.should include "href=\"#{client_invoices_path(client1)}\"",
                                   "href=\"#{client_invoices_path(client2)}\""
    end
  end
end
