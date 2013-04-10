class HomeController < ApplicationController
  def index
  	if current_user
  		@friends ||= current_user.facebook.get_connection("me", "friends?fields=id,name,picture.type(square)")
  	end
  end
end
