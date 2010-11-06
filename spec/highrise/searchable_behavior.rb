shared_examples_for "a searchable class" do
  it { subject.class.included_modules.should include(Highrise::Searchable) }

  it ".search" do
    find_args = {:from => "/#{subject.class.collection_name}/search.xml", :params => {"criteria[email]" => "john.doe@example.com", "criteria[zip]" => "90210"}}
    if subject.class.respond_to?(:find_all_across_pages)
      subject.class.should_receive(:find_all_across_pages).with(find_args)
    else
      subject.class.should_receive(:find).with(:all, find_args)
    end
    subject.class.search(:email => "john.doe@example.com", :zip => "90210")
  end
end
