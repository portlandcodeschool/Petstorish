class ProductsController < ApplicationController

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
    # these represent checkbox 
    # tick states.
    name = false
    description = false
     
    params[:options].each do |option|
      if option == 'name'
        name = true
      elsif option == 'description'
        description = true
      end
    end

    name_query = 'S+-=!'
    params[:query].split.each do |word|
      name_query += "AND (name LIKE '%" + word + "%') "
    end
 
    name_query.sub!('S+-=!AND', '')
    des_query = name_query.gsub('name', 'description')

    puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    puts 'name_query: ' + name_query
    puts 'des_query: ' + des_query

    if name and description
      @products = Product.where([
                          '((' + name_query + ') OR (' + des_query + ')) AND '+
                          '(price > :minimum) AND ' +
                          '(price < :maximum)',

                          :minimum => params[:price][:minimum],
                          :maximum => params[:price][:maximum]
      ])

    elsif name and !description
      @products = Product.where([
                          '('+name_query+') AND ' +
                          '(price > :minimum) AND ' +
                          '(price < :maximum)',

                          :minimum => params[:price][:minimum],
                          :maximum => params[:price][:maximum]
      ])


    elsif !name and description
      @products = Product.where([
                          '(' + des_query + ') AND ' +
                          '(price > :minimum) AND ' +
                          '(price < :maximum)',

                          :minimum => params[:price][:minimum],
                          :maximum => params[:price][:maximum]
      ])


    else #!name and !description
      @products = Product.where([

                          '(price > :minimum) AND ' +
                          '(price < :maximum)',

                          :minimum => params[:price][:minimum],
                          :maximum => params[:price][:maximum]
      ])

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
    end
  end

  def edit
    @product = Product.find(params[:id])
    @option = Option.new
  end

  def update
    @product = Product.find(params[:id])
    OptionAssignment.destroy_all(:product_id => @product.id)
    if params[:options]
      params[:options].each do |option|
        OptionAssignment.create(:option_id => option, :product_id => @product.id)
      end
    end
    if @product.update_attributes(params[:product])
      flash[:notice] = "SUPER DUPER success"
      redirect_to @product
    else
      flash[:errors] = @product.errors.messages
      render :action => :edit
    end
  end

  def delete
    @product = Product.find(params[:id])
  end

end
