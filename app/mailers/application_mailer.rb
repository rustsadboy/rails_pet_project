# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('GMAIL_EMAIL')
  layout 'mailer'
end
