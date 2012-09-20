require 'spec_helper'

describe Core::Model do 
  it 'should include Virtus' do 
    Core::Model.ancestors.should include Virtus
  end

  it 'should include the attribute _id' do 
    flag = false
    Core::Model.attribute_set.each do |attribute|
      flag = true if attribute.name == :_id
    end
    flag.should === true
  end
end