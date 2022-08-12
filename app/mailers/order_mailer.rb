# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  default to: ENV.fetch('GMAIL_USER')

  def contacts_mail(params)
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]
    @url = ENV.fetch('my_project_HOST')
    mail(subject: 'Rails my project')
  end
end
