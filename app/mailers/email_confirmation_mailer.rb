# frozen_string_literal: true

class EmailConfirmationMailer < ApplicationMailer
  def send_confirmation(user)
    @user = user
    @url = CodeHelper.generate_confirmation_url(@user)
    mail(to: @user.email, subject: 'Welcome')
  end
end
