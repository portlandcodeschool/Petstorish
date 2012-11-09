class Order < ActiveRecord::Base
  attr_accessible :user_id, :status, :cart
  validates_presence_of :user_id, :status
  belongs_to :cart


end
