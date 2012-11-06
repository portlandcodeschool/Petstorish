class ProductsController < ApplicationController

  before_filter :require_admin
  skip_before_filter :require_admin, :except => [:new, :create, :edit, :update]

  def require_admin
    if current_user.present?
      redirect_to products_path unless current_user.admin?
      return false
    else
      redirect_to products_path
      return false
    end
  end

  def home
    count = Product.count
    @products = []
    12.times do
      @products << Product.offset(rand(count)).first 
    end
  end

  def list
    @products = Product.where(:category => params[:category])
    #@products = Product.order(:id).page params[:page]
    if @products.empty?
      flash[:notice] = "We don't sell that.  Go to walmart."
      redirect_to :root
      return
    end
    @products = @products.page params[:page]
    render 'index'
  end

  def search
    @products = Product.where(['name LIKE :query', :query => "%#{params[:query]}%"])

    if @products.empty?
      redirect_to :root, :notice => "Sorry. We don't 'seal' that here."
      return
    end
    @products = @products.page params[:page]
    render 'index'

  end


  def adv_search

    
    # These represent checkbox states
    name = description = false

    if !params[:options].nil?
      params[:options].each do |option|
        if option == 'name'
          name = true
        elsif option == 'description'
          description = true
        end
      end
    end


    options = {
             :name => name,
             :description => description,
             :category => params[:category][:name],
             :price_minimum => params[:price][:minimum],
             :price_maximum => params[:price][:maximum]
              }

    @products = Searcher.advanced(params[:query], options)

    if @products.empty?
      redirect_to :root, :notice => "Sorry. We don't 'seal' that here."
      return
    end

    @products = @products.page params[:page]
 
    render 'index'

  end

  def index
    @products = Product.order(:id).page params[:page]
  end

#  def show
#    @product = Product.find(params[:id])
#  end

  def show
    @product = Product.find(params[:id])
    @line_item = LineItem.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(params[:product])
    if @product.save
      flash[:notice] = "SUPER DUPER success"
      redirect_to @product
    else
      flash[:errors] = @product.errors.messages
      redirect_to :action => "new"
      #TODO
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id]).include(:options)
    #OptionAssignment.destroy_all(:product_id => @product.id)
    @product.options.destroy
    if params[:options]
      params[:options].each do |option|
        #OptionAssignment.create(:option_id => option, :product_id => @product.id)
        @product.options.create(option)
      end
    end
    if @product.update_attributes(params[:product])
      flash[:notice] = "SUPER DUPER success"
      redirect_to @product
    else
      flash[:errors] = @product.errors.messages
      # TODO
      render :edit
    end
  end

  def delete
    @product = Product.find(params[:id])
  end

end
