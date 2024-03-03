# frozen_string_literal: true

class SubmitRecoveryPasswordMailer < ApplicationMailer
  def send_submit(user)
    @url = CodeHelper.generate_recovery_url(user)
    mail(to: user.email, subject: 'Password Recovery Submit')
  end
end
