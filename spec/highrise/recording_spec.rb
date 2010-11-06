require 'spec_helper'

describe Highrise::Recording do
  it { should be_a_kind_of Highrise::Base }

  it_should_behave_like "a paginated class"
end