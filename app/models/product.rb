class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :category
  attr_accessible :name, :description, :price, :image, :category
  has_attached_file :image

  has_many :options

  validates :price, 
    :numericality => { :greater_than => 0 },
    :format => { :with => /^(\d+)?\.?\d?\d?$/ }

  def self.categories 
    %w[pets toys food hats garments misc.]
  end
end
