class InvoiceMailer < ActionMailer::Base
  default from: "pete@jimsjamsmarmalades.com"
  
  def issue(invoice)
    fail 'Only saved invoices can be issued' unless invoice.persisted?
    @invoice = invoice
    @client = invoice.client
    mail(:to => "#{@client.name} <#{@client.email}>", :subject => "Jim's Jams and Marmalades Invoice #{@invoice.id}")
  end
end
