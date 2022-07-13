class ContactsController < ApplicationController
	def new
	  p "HELLO THERE"
	  p ENV['GMAIL_USER']
	  p ENV['GMAIL_PASSWORD']
	end

	def create
    	OrderMailer.contacts_mail(contacts_params).deliver_now
    	redirect_to root_path
  	end

	private

	def contacts_params
    	params.permit(:name, :email, :message)
  	end
end