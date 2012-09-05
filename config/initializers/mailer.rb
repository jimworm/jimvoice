ActionMailer::Base.smtp_settings = {
  address:               'smtp.gmail.com',
  port:                  587,
  domain:                'gmail.com',
  username:              ENV['EMAIL_USERNAME'],
  password:              ENV['EMAIL_PASSWORD'],
  authentication:        'plain',
  enable_starttls_auto:  true
}