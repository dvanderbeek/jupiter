class Calendar < ActiveRecord::Base
  belongs_to :user
  attr_accessible :calendar_id
end
