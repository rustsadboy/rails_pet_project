# frozen_string_literal: true

class ResetPasswordMailer < ApplicationMailer
  def send_new_password(user, new_password)
    @new_password = new_password

    mail(to: user.email, subject: 'New Password')
  end
end
