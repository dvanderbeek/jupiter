class Contact < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :name
end