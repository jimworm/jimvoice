require 'spec_helper'

describe HomeController do
  describe "#index" do
    it "redirects to clients" do
      get :index
      response.should redirect_to clients_path
    end
  end
end
