shared_examples_for "a taggable class" do
  before(:each) do
    (@tags = []).tap do
      @tags << Highrise::Tag.new(:name => "cliente", :id => 414578)
      @tags << Highrise::Tag.new(:name => "ged", :id => 414580)
      @tags << Highrise::Tag.new(:name => "iepc", :id => 414579)
    end
  end

  it { subject.class.included_modules.should include(Highrise::Taggable) }

  it "#tag!(tag_name)" do
    subject.should_receive(:post).with(:tags, :name => "client" ).and_return(true)
    subject.tag!("client").should be_true
  end

  it "#untag!(tag_name)" do
    subject.should_receive(:tags).and_return(@tags)
    subject.should_receive(:delete).with("tags/414578").and_return(true)
    subject.untag!("cliente").should be_true
  end
end
