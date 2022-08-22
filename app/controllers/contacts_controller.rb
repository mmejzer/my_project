# frozen_string_literal: true

class ContactsController < ApplicationController
  def new; end

  def create
    OrderMailer.contacts_mail(contacts_params).deliver_now
    redirect_to root_path, notice: 'Message sent'
  end

  private

  def contacts_params
    params.permit(:name, :email, :message)
  end
end
