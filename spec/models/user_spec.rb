require 'spec_helper'

describe "User" do
  let(:user) { FactoryGirl.build(:user) }
  
  describe "attributes" do
    describe ":name" do
      it "is required" do
        user.name = nil
        user.should_not be_valid
      end
      
      it "cannot be shorter than 3 characters" do
        user.name = 'ji'
        user.should_not be_valid
      end
    end
  end
  
  describe "public methods" do
  end
end
