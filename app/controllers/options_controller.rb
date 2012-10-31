class OptionsController < ApplicationController
  def index
    @options = Option.all

  end

  def show
    @option = Option.find(params[:id])

  end

  # GET /options/new
  def new
    @option = Option.new
  end

  # GET /options/1/edit
  def edit
    @option = Option.find(params[:id])
  end

  # POST /options
  def create
#    @option = Option.new(params[:option])
    respond_to do |format| # for ajax call in Product edit page
      format.json { 
        @option = Option.new
        @option.value = params[:value].downcase
        @option.family = params[:family].downcase 
        @nope = {:message => "Value already exists"}
        if @option.save
          render :status => 201, :json => @option
        else
          render :status => 200, :json => @nope
        end
      }
    
      format.html {
        @option = Option.new
        @option.value = params[:option][:value].downcase
        @option.family = params[:option][:family].downcase 
        @option.save
        if @option.save
          redirect_to @option, notice: "Option was successfully created."
        else
          render action: "new"
        end
      }
    end
  end

  # PUT /options/1
  def update
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      redirect_to @option, notice: 'Option was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /options/1
  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    redirect_to options_url
  end

end
