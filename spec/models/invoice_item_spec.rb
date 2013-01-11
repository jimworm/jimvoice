require 'spec_helper'

describe "InvoiceItem" do
  let(:invoice_item) { FactoryGirl.build :invoice_item }
  let(:invoice) { invoice_item.invoice }
  
  it "has a valid factory" do
    invoice_item.should be_valid
  end
  
  describe "attributes" do
    describe ":amount" do
      it "is required" do
        invoice_item.amount = nil
        invoice_item.should_not be_valid
      end
      
      it "is a number" do
        invoice_item.amount = 'NaN'
        invoice_item.should_not be_valid
      end
    end
    
    describe ":name" do
      it "is required" do
        invoice_item.name = nil
        invoice_item.should_not be_valid
      end
    end
    
    describe ":description" do
      # No requirements
    end
  end
  
  describe "associations" do
    describe ":invoice" do
      it "is required" do
        invoice_item.invoice = nil
        invoice_item.should_not be_valid
      end
      
      context "when sent" do
        it "is invalid" do
          invoice.sent = true
          invoice_item.should_not be_valid
        end
      end
      
      context "when paid" do
        it "is invalid" do
          invoice.paid = true
          invoice_item.should_not be_valid
        end
      end
    end
  end
  
  describe "public methods" do
    describe "#destroy" do
      it "fails when invoice is paid" do
        invoice.paid = true
        invoice_item.destroy.should be_false
      end
      
      it "fails when invoice is sent" do
        invoice.sent = true
        invoice_item.destroy.should be_false
      end
    end
  end
end
