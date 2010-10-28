require 'spec_helper'

describe Highrise::Task do
  it {subject.should be_a_kind_of Highrise::Base }
  
  it "#complete!" do
    subject.should_receive(:load_attributes_from_response).with("post")
    subject.should_receive(:post).with(:complete).and_return("post")
    subject.complete!
  end
end
