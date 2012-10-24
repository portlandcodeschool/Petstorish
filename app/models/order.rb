class Order < ActiveRecord::Base
  attr_accessible :user_id, :status
  validates_presence_of :user_id, :status
end
