class UsersController < ApplicationController
	before_filter :authenticate, only: :index

	def index

	end

	def update
		current_user.update_attributes(params[:user])
		redirect_to '/invite_friends', notice: "Activity prefrences updated!"
	end


protected

	def authenticate
	  authenticate_or_request_with_http_basic do |username, password|
	    username == "foo" && password == "bar"
	  end
	end
end