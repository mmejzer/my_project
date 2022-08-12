# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default to: ENV.fetch('GMAIL_USER')

  def contacts_mail(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = ENV.fetch('HOST')
    mail(subject: "Rails my project: User #{@name} sent you a message")
  end
end
