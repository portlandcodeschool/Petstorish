require 'spec_helper'

describe Option do
  context "validates fields"
    before(:each) do
      @valid_attributes = {
        :family => "color",
        :value => "aquamarine"
      }
    @option = Option.create
    end

    it 'should be valid with all options' do
      @option.attributes = @valid_attributes
      @option.should be_valid
    end

    it 'requires a family' do
      @option.attributes = @valid_attributes.except(:family)
      @option.should_not be_valid
    end
    it 'requires a value' do
      @option.attributes = @valid_attributes.except(:value)
      @option.should_not be_valid
    end
end
