require 'spec_helper'

describe Highrise::Base do
  it { subject.should be_a_kind_of ActiveResource::Base }
end
