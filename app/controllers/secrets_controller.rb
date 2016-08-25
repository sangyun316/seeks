class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]
  def index
  	@secrets = Secret.all
  end

  def create
		secret = User.find(session[:user_id]).secrets.create(content: params[:content])
		if secret.valid? 
			redirect_to "/users/#{session[:user_id]}"
		else
			flash[:errors] = secret.errors.full_messages
			redirect_to "/users/#{session[:user_id]}"
		end
	end
	def destroy
		Secret.find(params[:id]).destroy
		redirect_to "/users/#{session[:user_id]}"
	end
end
