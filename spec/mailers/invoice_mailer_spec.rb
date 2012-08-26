require "spec_helper"

describe "InvoiceMailer" do
  let(:invoice) { FactoryGirl.build(:invoice) }
  
  describe ".issue" do
    let(:mailer) { InvoiceMailer.issue(invoice) }
    
    before do
      2.times { invoice.items << FactoryGirl.build(:invoice_item, invoice: invoice) }
    end
    
    context "when not saved" do
      it "raises an error" do
        expect { mailer }.to raise_error
      end
    end
    
    context "when saved" do
      before { invoice.save }
      
      it "renders successfully" do
        expect { mailer }.not_to raise_error
      end
    
      it "is sent to the invoice's client" do
        mailer.to.should include(invoice.client.email)
      end
      
      it "delivers successfully" do
        expect { mailer.deliver }.not_to raise_error
      end
      
      context "when not sent before" do
        before { invoice.sent = false }
      
        it "is not marked as a copy" do
          mailer.body.should_not include("INVOICE COPY")
        end
      end
    
      context "when sent before" do
        before { invoice.sent = true }
      
        it "is marked as a copy" do
          mailer.body.should include("INVOICE COPY")
        end
      end
    end
  end
end
