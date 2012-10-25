require 'spec_helper'

describe UsersController do

  describe "GET edit" do
  
    before(:each) do
      @user = mock_model(User)
      User.stub(:find).and_return(@user)
    end

    it "should find the user" do
      User.should_receive(:find).and_return(@user)
      get :edit, :id => @user.id
    end

    it "should render the edit layout" do
      get :edit, :id => @user.id
      response.should render_template('users/edit')
    end

  end

  describe "POST update" do
   # let(:user) { mock_model(User).as_null_object }

    before(:each) do
      @user = mock_model(User)
      User.stub(:find).and_return(@user)
      @user.stub(:update_attributes).and_return(true)
      @user.stub(:id).and_return('12')
    end

    it "saves the user" do
      @user.should_receive(:update_attributes).and_return(true)
      post :update, :id => @user.id

    end

    context "when the user updates successfully" do
      it "sets a flash[:notice] message" do
        post :update, :id => @user.id
        flash[:notice].should match('updated')
      end

      it "redirects to the Users show action" do
        post :update, :id => @user.id
        response.should redirect_to(:action => "show")
      end
    end

    context "when the user fails to update" do

      before do
        @user.stub(:update_attributes).and_return(false)
      end
      


      it "sets a flash[:notice] message" do
        post :update, :id => @user.id
        flash[:notice].should match('failed')
      end
      it "returns the user to their edit page" do
        post :update, :id => @user.id
        response.should redirect_to(:action => "edit")
      end

    end #context when the user fails to update
  end #describe "POST update" 


  describe "GET show" do

    before(:each) do
      @user = mock_model(User)
      User.stub(:find).and_return(@user)
    end
    
    it "finds the user" do
      User.should_receive(:find).and_return(@user)
      get :show, :id => @user.id
    end 

    it "renders the show page" do

      get :show, :id => @user.id
      response.should render_template('users/show')
    end
  end #describe "GET...
end #File

