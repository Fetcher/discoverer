require 'spec_helper'

describe Core::Model do 
  it 'should include Virtus' do 
    Core::Model.ancestors.should include Virtus
  end
end