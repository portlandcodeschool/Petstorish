require 'spec_helper'

describe User do
  
  context "validating presence of fields" do


    it 'should not have a turtle field' do
      @user = User.new
      expect { user.turtle }.to raise_error
    end 
  
  end
end
