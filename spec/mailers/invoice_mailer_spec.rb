require "spec_helper"

describe "InvoiceMailer" do
  let(:invoice) { FactoryGirl.build(:invoice) }
  
  describe ".issue" do
    let(:mailer) { InvoiceMailer.issue(invoice) }
    
    before do
      2.times { invoice.items << FactoryGirl.build(:invoice_item, invoice: invoice) }
      invoice.save!
    end
    
    it "renders successfully" do
      expect { mailer }.not_to raise_error
    end
  
    it "is sent to the invoice's client" do
      mailer.to.should include(invoice.client.email)
    end
    
    it "is bcc'd to the finance contact" do
      mailer.bcc.should include('finance@example.com')
    end
    
    it "has the right subject" do
      mailer.subject.should include("Example.com Invoice")
    end
    
    context "when not in production" do
      before { Rails.env.stub(:production?).and_return(false) }
      after { Rails.env.unstub(:production?) }
      
      it "has a test subject" do
        mailer.subject.should include('[TEST]')
      end
    end
    
    context "when in production" do
      before { Rails.env.stub(:production?).and_return(true) }
      after { Rails.env.unstub(:production?) }
      
      it "doesn't have a test subject" do
        mailer.subject.should_not include('[TEST]')
      end
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
  end # issue
end
