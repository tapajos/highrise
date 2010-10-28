require 'spec_helper'

describe Highrise::Taggable do
  class TestClass < Highrise::Base; include Highrise::Taggable; end
  
  subject { TestClass.new }
  
  before(:each) do
    (@tags = []).tap do 
      @tags << {'id' => "414578", 'name' => "cliente"}
      @tags << {'id' => "414580", 'name' => "ged"}
      @tags << {'id' => "414579", 'name' => "iepc"}
    end
  end

  it { subject.class.included_modules.should include(Highrise::Taggable) }

  it "#tags" do
    subject.should_receive(:get).with(:tags).and_return(@tags)
    subject.tags.should == @tags
  end
  
  it "#tag!(tag_name)" do
    subject.should_receive(:post).with(:tags, :name => "client" ).and_return(true)
    subject.tag!("client").should be_true
  end
  
  it "#untag!(tag_name)" do
    subject.should_receive(:get).with(:tags).and_return(@tags)
    subject.should_receive(:delete).with("tags/414578").and_return(true)
    subject.untag!("cliente").should be_true
  end
end
