require 'spec_helper'

describe "Client" do
  let(:client) { FactoryGirl.build :client }
  
  describe "attributes" do
    describe ":email" do
      it "is required" do
        client.email = nil
        client.should_not be_valid
        client.errors[:email].should_not be_empty
      end
      
      it "is an email address" do
        client.email = 'invalidemail'
        client.should_not be_valid
        client.errors[:email].should_not be_empty
      end
      
      it "is unique" do
        client.save!
        new_client = FactoryGirl.build :client, email: client.email
        new_client.should_not be_valid
        new_client.errors[:email].should_not be_empty
      end
    end
    
    describe ":name" do
      it "is required" do
        client.name = nil
        client.should_not be_valid
        client.errors[:name].should_not be_empty
      end
    end
  end
  
  describe "public methods" do
  end
end
