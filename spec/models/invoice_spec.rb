require 'spec_helper'

describe "Invoice" do
  let(:invoice) { FactoryGirl.build :invoice }
  
  describe "attributes" do
    describe ":currency" do
      it "is required" do
        invoice.currency = nil
        invoice.should_not be_valid
      end
    end
  end
  
  describe "associations" do
    describe ":client" do
      it "is required" do
        invoice.client = nil
        invoice.should_not be_valid
      end
    end
    
    describe ":items" do
      it "is composed of InvoiceItems" do
        invoice.items.build.should be_a_kind_of(InvoiceItem)
      end
    end
  end
  
  describe "public methods" do
    describe "#total" do
      before do
        invoice.items = 3.times.map{FactoryGirl.build :invoice_item, invoice: invoice, amount: 100.0}
        invoice.save!
      end
      
      it "is the total amount of all :invoice_items" do
        invoice.total.should == 300.0
      end
    end
    
    describe "#reference" do
      it "is the letters JM with a 6-zero-padded :id" do
        invoice.stub(:id).and_return(3)
        invoice.reference.should == 'JM000003'
      end
    end
    
    describe "#send!" do
      before { invoice.save! }
      
      it "sets :sent to true" do
        invoice.send!
        invoice.should be_sent
      end
      
      it "sets :sent_at to today" do
        invoice.send!
        invoice.sent_at.should == Date.today
      end
    end
  end
end
