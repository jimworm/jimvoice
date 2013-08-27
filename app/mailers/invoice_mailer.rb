class InvoiceMailer < ActionMailer::Base
  default from: CONFIG[:company][:billing_email]
  
  def issue(invoice)
    @invoice  = invoice
    @client   = invoice.client
    mail  to: "#{@client.name} <#{@client.email}>",
          bcc: CONFIG[:company][:finance_contact],
          subject: "#{'[TEST] ' unless Rails.env.production?}#{CONFIG[:company][:name]} Invoice #{@invoice.id}"
  end
end
