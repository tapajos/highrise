require 'spec_helper'

describe Highrise::SubjectData do
  it { should be_a_kind_of Highrise::Base }  
  
  it "Two different subject datas with different values are not equal" do
    martini = Highrise::SubjectData.new({:id => 1, :value => "Martini", :subject_field_id => 3, :subject_field_label => "Cocktail"})
    sling = Highrise::SubjectData.new({:id => 2, :value => "Singapore Sling", :subject_field_id => 4, :subject_field_label => "Cocktail"})
    martini.should_not==sling
  end

  it "Two different subject datas with different labels are not equal" do
    martini = Highrise::SubjectData.new({:id => 1, :value => "Martini", :subject_field_id => 3, :subject_field_label => "Cocktail"})
    sling = Highrise::SubjectData.new({:id => 2, :value => "Martini", :subject_field_id => 4, :subject_field_label => "Vermouth Brands"})
    martini.should_not==sling
  end
  
  it "Two the same subject datas are equal" do
    martini = Highrise::SubjectData.new({:id => 1, :value => "Martini", :subject_field_id => 3, :subject_field_label => "Cocktail"})
    another_martini = Highrise::SubjectData.new({:id => 2, :value => "Martini", :subject_field_id => 4, :subject_field_label => "Cocktail"})
    martini.should==another_martini
  end
  
end