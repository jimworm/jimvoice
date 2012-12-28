require 'spec_helper'

describe ClientsController do
  let(:client1) { FactoryGirl.create :client, name: 'Dooby Doo Corp' }
  let(:client2) { FactoryGirl.create :client, name: 'Shooby Dua Ltd' }
  
  before do
    client1
    client2
  end
  
  describe "#index" do
    render_views
    
    it "shows the client index" do
      get :index
      response.body.should include 'Dooby Doo Corp'
      response.body.should include 'Shooby Dua Ltd'
    end
    
    it "links to the clients' invoice index pages" do
      pending
      # get :index
      # click_link "#show_client_#{client1.id}"
      # response.should have_content 'Dooby Doo Corp'
    end
  end
end
