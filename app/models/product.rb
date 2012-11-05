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

  def self.search(query, options)
    
    #return if query.blank?
    #return if options[:name].blank? and options[:description].blank?

    clause = ['']
    search_idea = ''
    number_of_clauses = 0

    if options[:name]
      search_idea << "OR name LIKE ? "
      number_of_clauses += 1
    end

    if options[:description]
      search_idea << "OR description LIKE ? "
      number_of_clauses += 1
    end
    
    if number_of_clauses > 0
      query.split(' ').each do |term|
        clause[0] << search_idea 
        # we need to append the term twice if both conditions are searchable
        number_of_clauses.times {clause <<  ('%' << term << '%')}
      end
    end

    # because category can be set as all,
    # detect the case and set it as a wildcard
    if options[:category] == 'all'
      options[:category] = '%'
    end

    # strip leading OR
    clause[0].sub!('OR', '')
    results =  Product.where(clause).where(
      ['price > ? AND price < ? and category LIKE ?',
        options[:price_minimum],
        options[:price_maximum],
        options[:category]])

    if results.empty?
      return []
    end
    debugger
    results
  end
  
  def self.categories
    %w[pets toys food hats garments misc]
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
