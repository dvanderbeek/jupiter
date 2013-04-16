class CalendarsController < ApplicationController
	def update_calendars
		current_user.calendars.destroy_all
		params[:calendars].each do |calendar|
			current_user.calendars.where(calendar_id: calendar).first_or_initialize do |cal|
				cal.calendar_id = calendar
				cal.save unless cal.calendar_id.blank?
			end
		end
		redirect_to root_url
	end
end