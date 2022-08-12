# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default to: ENV.fetch('GMAIL_USER', nil)

  def contacts_mail(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = ENV.fetch('HOST', nil)
    mail(subject: "Rails my project #{@first_name} sent you a message")
  end
end
