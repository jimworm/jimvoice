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
      
      context "when updating" do
        before { invoice_item.save! }
        
        context "and sent" do
          before { invoice.update_attribute :sent, true }
          
          it "is immutable" do
            invoice_item.stub(:amount_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:amount].should_not be_empty
          end
        end
        
        context "and paid" do
          before { invoice.update_attribute :paid, true }
          
          it "is immutable" do
            invoice_item.stub(:amount_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:amount].should_not be_empty
          end
        end
      end
    end
    
    describe ":name" do
      it "is required" do
        invoice_item.name = nil
        invoice_item.should_not be_valid
      end

      context "when updating" do
        before { invoice_item.save! }

        context "and sent" do
          before { invoice.update_attribute :sent, true }
          
          it "is immutable" do
            invoice_item.stub(:name_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:name].should_not be_empty
          end
        end

        context "and paid" do
          before { invoice.update_attribute :paid, true }

          it "is immutable" do
            invoice_item.stub(:name_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:name].should_not be_empty
          end
        end
      end
    end
    
    describe ":description" do
      context "when updating" do
        before { invoice_item.save! }
        
        context "and sent" do
          before { invoice.update_attribute :sent, true }
          
          it "is immutable" do
            invoice_item.stub(:description_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:description].should_not be_empty
          end
        end
        
        context "and paid" do
          before { invoice.update_attribute :paid, true }
          
          it "is immutable" do
            invoice_item.stub(:description_changed?).and_return(true)
            invoice_item.should_not be_valid
            invoice_item.errors[:description].should_not be_empty
          end
        end
      end
    end
  end
  
  describe "associations" do
    describe ":invoice" do
      it "is required" do
        invoice_item.invoice = nil
        invoice_item.should_not be_valid
      end
    end
  end
end
