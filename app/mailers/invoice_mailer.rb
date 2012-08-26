class InvoiceMailer < ActionMailer::Base
  default from: "invoice_mailer@jimsjams.com.hk"
  
  def issue(invoice)
    fail 'Only saved invoices can be issued' unless invoice.persisted?
    @invoice = invoice
    @client = invoice.client
    mail(:to => "#{@client.name} <#{@client.email}>", :subject => "Invoice #{@invoice.id}")
  end
end
