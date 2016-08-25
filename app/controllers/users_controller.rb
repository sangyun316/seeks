class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def index

	end
	
	def new
	end
	
	def show
		@user = User.find(params[:id])
	end
	
	def create
		user = User.create(user_params)
		if user.valid? 
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to '/users/new'
		end
	end	

	def edit
		@user = User.find(params[:id])
	end
	
	def update
		user = User.find(params[:id])
		puts params[:id]
		updated = User.update(user.id, user_params)
		redirect_to "/users/#{user.id}"
	end
	def destroy
		user = User.find(params[:id])
		user.destroy
		session[:user_id] = nil
		
		redirect_to '/sessions/new'
	end
	private
	def user_params
		params.require(:u).permit(:email, :name, :password, :password_confirmation)
	end
end