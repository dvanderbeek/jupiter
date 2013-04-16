class Activity < ActiveRecord::Base
  attr_accessible :name

  has_many :activities_users
  has_many :users, through: :activities_users
end
