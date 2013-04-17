class UsersController < ApplicationController
	def update
		current_user.update_attributes(params[:user])
		redirect_to root_url, notice: "Activity prefrences updated!"
	end
end