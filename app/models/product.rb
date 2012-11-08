class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price, :category
  attr_accessible :name, :description, :price, :image, :category, :option_assignments
  has_attached_file :image, :styles => {thumbnail: "100x100>", display: "500x500>"}

  has_many :option_assignments
  has_many :options, :through => :option_assignments
  # accepts_nested_attributes_for :option_assignments

  has_many :line_items

  before_destroy
    :ensure_not_referenced_by_any_line_item

  validates :price,
    :numericality => { :greater_than => 0 },
    :format => { :with => /^(\d+)?\.?\d?\d?$/ }


  def self.categories
    %w[pets toys food hats duds misc]
  end

  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, "This product can't be deleted because it's referenced in the line items table.")
      return false
    end
  end

end
