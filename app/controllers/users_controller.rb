class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
    
      flash[:notice] = 'User updated successfully'
      redirect_to(@user)
    
    else
      flash[:notice] = 'Update failed.  Probably because of something *you* typed.'
      redirect_to :action => :edit 
    end

  end

end
