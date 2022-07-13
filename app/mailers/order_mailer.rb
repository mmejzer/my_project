class OrderMailer < ApplicationMailer
	default to: 'mmejzer@gmail.com'

	def contacts_mail(params)
		@name = params[:name]
    	@email = params[:email]
    	@message = params[:message]
    	@url = 'http://localhost:3000/'
    	mail(subject: "Rails my project")
	end
end