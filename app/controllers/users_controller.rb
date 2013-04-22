class UsersController < ApplicationController
	def update
		current_user.update_attributes(params[:user])
		redirect_to '/invite_friends', notice: "Activity prefrences updated!"
	end
end