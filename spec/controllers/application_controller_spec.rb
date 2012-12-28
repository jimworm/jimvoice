require 'spec_helper'

describe "ApplicationController" do
  let!(:user) { FactoryGirl.create :user, name: 'user', password: 'password', password_confirmation: 'password' }
  
  controller do
    def index
      render text: 'Success'
    end
  end
  
  before do
    controller.unstub(:authenticate!)
    controller.unstub(:current_user)
  end
  
  describe "before_filters" do
    describe "#authenticate!" do
      it "allows login" do
        request.env["HTTP_AUTHORIZATION"] = "Basic #{Base64::encode64('user:password')}"
        get :index
        assert_response :success
        assigns(:current_user).should == user
      end
  
      it "disallows wrong password" do
        request.env["HTTP_AUTHORIZATION"] = "Basic #{Base64::encode64('user:wrong_password')}"
        get :index
        assert_response :unauthorized
        assigns(:current_user).should be_nil
      end
    
      it "disallows unknown user" do
        request.env["HTTP_AUTHORIZATION"] = "Basic #{Base64::encode64('wrong_user:password')}"
        get :index
        assert_response :unauthorized
        assigns(:current_user).should be_nil
      end
    end
  end # before_filters
end
