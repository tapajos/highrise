require 'spec_helper'

describe Highrise::Company do
  subject { Highrise::Company.new(:id => 1) }
  
  it { should be_a_kind_of Highrise::Base }
  it_should_behave_like "a paginated class"
  it_should_behave_like "a taggable class"
  it_should_behave_like "a searchable class"

  it "#people" do
    Highrise::Person.should_receive(:find_all_across_pages).with(:from=>"/companies/1/people.xml").and_return("people")
    subject.people.should == "people"
  end

  describe "Custom fields" do

    before (:each) do
      @fruit_company = Highrise::Company.new({ :company => {
                        :id => 1,
                        :name => "John Doe & Co.",
                        :subject_datas => [{
                          :subject_field_label => "Fruit Banana",
                          :value => "Yellow"
                        }, {
                          :subject_field_label => "Fruit Grape",
                          :value => "Green"
                        }]
                      }
                    })
      @subject_field_blueberry = Highrise::SubjectField.new ({:id => 1, :label => "Fruit Blueberry"})
      @subject_field_papaya = Highrise::SubjectField.new ({:id => 2, :label => "Fruit Papaya"})
    end

    it "Can get the value of a custom field via the field method" do
      @fruit_company.field("Fruit Banana").should== "Yellow"
    end

    it "Can get the value of a custom field using a custom method call" do
      @fruit_company.fruit_grape.should== "Green"
    end

    it "Will raise an exception on an unknown field" do
      expect {@fruit_company.unknown_fruit}.to raise_exception(NoMethodError)
    end

    it "Can set the value of a custom field via the field method" do
      @fruit_company.set_field_value("Fruit Grape", "Red")
      @fruit_company.field("Fruit Grape").should== "Red"
    end

    it "Can set the value of a custom field" do
      @fruit_company.fruit_grape= "Red"
      @fruit_company.field("Fruit Grape").should== "Red"
    end

    it "Assignment just returns the arguments (like ActiveResource base does)" do
      Highrise::SubjectField.should_receive(:find).with(:all).and_return []
      (@fruit_company.unknown_fruit = 10).should== 10
    end

    it "Can deal with the find returning nil (which is a bit ugly in the ActiveResource API)" do
      Highrise::SubjectField.should_receive(:find).with(:all).and_return nil
      (@fruit_company.unknown_fruit = 10).should== 10
    end

    it "Can set the value of a custom field that wasn't there via the field method, but that was defined (happens on new Person)" do
      Highrise::SubjectField.should_receive(:find).with(:all).and_return([@subject_field_papaya, @subject_field_blueberry])
      @fruit_company.set_field_value("Fruit Blueberry", "Purple")
      @fruit_company.field("Fruit Blueberry").should== "Purple"
      @fruit_company.attributes["subject_datas"][2].subject_field_id.should == 1
    end

    it "Can still set and read the usual way of reading attrivutes" do
      @fruit_company.name = "Jacob"
      @fruit_company.name.should== "Jacob"

    end

  end

  it { subject.label.should == 'Party' }
end
