class InvoiceMailer < ActionMailer::Base
  default from: "BillBot <billbot@jimsjamsmarmalades.com>"
  
  def issue(invoice)
    @invoice = invoice
    @client = invoice.client
    mail(to: "#{@client.name} <#{@client.email}>", cc: "Robert Hau <robert@jimsjamsmarmalades.com>", subject: "#{'[TEST] ' unless Rails.env.production?}Jim's Jams and Marmalades Invoice #{@invoice.id}")
  end
end
