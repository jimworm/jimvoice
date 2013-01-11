require 'spec_helper'

describe ClientsController do
  let(:client1) { FactoryGirl.create :client, name: 'Dooby Doo Corp', email: 'bing.crosby@example.com' }
  let(:client2) { FactoryGirl.create :client, name: 'Shooby Dua Ltd' }
  
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
  
end
