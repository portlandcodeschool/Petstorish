class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  validates_presence_of :email, :password, :credit_card, :address
  attr_accessible :email, :password, :password_confirmation, :remember_me, :credit_card, :address, :admin #remove the last one sometime



end
