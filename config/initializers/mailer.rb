ActionMailer::Base.smtp_settings = CONFIG[:mailer].symbolize_keys if CONFIG[:mailer]
