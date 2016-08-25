class LikesController < ApplicationController
	def create
		current_user.likes.create(secret: Secret.find(params[:secret_id]))
		redirect_to '/secrets'
	end
	def destroy
		like = current_user.likes.where(secret: Secret.find(params[:id]))
		like.destroy_all
		redirect_to '/secrets'
	end
end
