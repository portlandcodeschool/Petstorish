class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :category
  attr_accessible :name, :description, :price, :image, :category, :option_assignments
  has_attached_file :image

  has_many :option_assignments
  accepts_nested_attributes_for :option_assignments

  validates :price,
    :numericality => { :greater_than => 0 },
    :format => { :with => /^(\d+)?\.?\d?\d?$/ }


  def build_option_assignments
    #try this?
  end

  def has_option option_id
    OptionAssignment.where(:option_id => option_id, :product_id => self.id).count > 0
  end


  def self.categories
    %w[pets toys food hats garments misc.]
  end
end
