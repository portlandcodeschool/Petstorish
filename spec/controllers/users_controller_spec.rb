require 'spec_helper'

describe UsersController do

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

    end
  end
end

