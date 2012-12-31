require 'spec_helper'

describe "Invoice" do
  let(:invoice) { FactoryGirl.build :invoice }
  
  describe "attributes" do
    describe ":currency" do
      it "is required" do
        invoice.currency = nil
        invoice.should_not be_valid
      end
      
      it "must be 3 characters long (ISO 4217)" do
        invoice.currency = 'un'
        invoice.should_not be_valid
        
        invoice.currency = 'uned'
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
    describe "#issued?" do
      it "is true when sent" do
        invoice.sent = true
        invoice.should be_issued
      end
      
      it "is true when paid" do
        invoice.paid = true
        invoice.should be_issued
      end
      
      it "is false if unsent and unpaid" do
        invoice.should_not be_issued
      end
    end
    
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
    
    describe "#issue!" do
      context "when not saved" do
        before { 2.times { invoice.items << FactoryGirl.build(:invoice_item, invoice: invoice) } }
        
        it "fails" do
          expect { invoice.issue! }.to raise_error
        end
      end
      
      context "when has no items" do
        before { invoice.save! }
        
        it "fails" do
          expect { invoice.issue! }.to raise_error
        end
      end
      
      context "when saved and has items" do
        before do
          2.times { invoice.items << FactoryGirl.build(:invoice_item, invoice: invoice) }
          invoice.save!
        end
      
        it "sets :sent to true" do
          invoice.issue!
          invoice.should be_sent
        end
      
        it "sets :sent_at to today" do
          invoice.issue!
          invoice.sent_at.should == Date.today
        end
      end
    end
  end
end
