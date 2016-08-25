class SessionsController < ApplicationController
	def new
	end
	def create
		user = User.find_by(email: user_params[:email])
		if user && user.authenticate(user_params[:password])
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = ["Invalid"]
			redirect_to '/sessions/new'
		end
	end
	
	def delete
		session[:user_id] = nil

		redirect_to '/sessions/new'
	end
	private
	def user_params
		params.require(:u).permit(:email, :password)
	end
end