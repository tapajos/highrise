# encoding: utf-8
require 'spec_helper'

describe Highrise::Person do
  subject { Highrise::Person.new(:id => 1) }

  it { should be_a_kind_of Highrise::Subject }

  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"
  it_should_behave_like "a searchable class"

  describe "#company" do
    it "returns nil when it doesn't have a company" do
      subject.should_receive(:company_id).and_return(nil)
      subject.company.should be_nil
    end

    it "delegate to Highrise::Company when have company_id" do
      subject.should_receive(:company_id).at_least(2).times.and_return(1)
      Highrise::Company.should_receive(:find).with(1).and_return("company")
      subject.company.should == "company"
    end
  end

  it "#name" do
    subject.should_receive(:first_name).and_return("Marcos")
    subject.should_receive(:last_name).and_return("Tapajós     ")
    subject.name.should == "Marcos Tapajós"
  end

  describe "#tags" do
    before(:each) do
      (@tags = []).tap do
        @tags << {'id' => "414578", 'name' => "cliente"}
        @tags << {'id' => "414580", 'name' => "ged"}
        @tags << {'id' => "414579", 'name' => "iepc"}
      end
      subject.attributes["tags"] = @tags
    end
    it {
      subject.tags.should == @tags
    }
  end

  it { subject.label.should == 'Party' }
end
