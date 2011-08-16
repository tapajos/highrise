shared_examples_for "a paginated class" do
  it { subject.class.included_modules.should include(Highrise::Pagination) }

  it ".find_all_across_pages" do
    subject.class.should_receive(:find).with(:all,{:params=>{:n=>0}}).and_return(["things"])
    subject.class.should_receive(:find).with(:all,{:params=>{:n=>1}}).and_return([])
    subject.class.find_all_across_pages.should == ["things"]
  end
  
  it ".find_all_across_pages with zero results" do
    subject.class.should_receive(:find).with(:all,{:params=>{:n=>0}}).and_return(nil)
    subject.class.find_all_across_pages.should == []
  end

  it ".find_all_across_pages_since" do
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    subject.class.should_receive(:find_all_across_pages).with({:params=>{:since=>"20090114174311"}}).and_return("result")
    subject.class.find_all_across_pages_since(time).should == "result"
  end
  
  it ".find_all_deletions_across_pages" do
    class TestClass2 < Highrise::Base; include Highrise::Pagination; end
    subject_type = subject.class.to_s.split('::').last
    deleted_resource_1 = subject.class.new(:id => 12, :type => subject_type)
    deleted_resource_2 = TestClass2.new(:id => 34, :type => 'TestClass2')
    deleted_resource_3 = subject.class.new(:id => 45, :type => subject_type)
    
    subject.class.should_receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1}}).and_return([deleted_resource_1, deleted_resource_2, deleted_resource_3])
    subject.class.should_receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>2}}).and_return([])
    subject.class.find_all_deletions_across_pages.should == [deleted_resource_1, deleted_resource_3]
  end
  
  it ".find_all_deletions_across_pages with zero results" do
    subject.class.should_receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1}}).and_return(nil)
    subject.class.find_all_deletions_across_pages.should == []
  end

  it ".find_all_deletions_across_pages_since" do
    class TestClass2 < Highrise::Base; include Highrise::Pagination; end
    subject_type = subject.class.to_s.split('::').last
    time = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    deleted_resource_1 = subject.class.new(:id => 12, :type => subject_type)
    deleted_resource_2 = TestClass2.new(:id => 34, :type => 'TestClass2')
    deleted_resource_3 = subject.class.new(:id => 45, :type => subject_type)

    subject.class.should_receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>1, :since=>"20090114174311"}}).and_return([deleted_resource_1, deleted_resource_2, deleted_resource_3])
    subject.class.should_receive(:find).with(:all,{:from => '/deletions.xml', :params=>{:n=>2, :since=>"20090114174311"}}).and_return([])
    subject.class.find_all_deletions_across_pages_since(time).should == [deleted_resource_1, deleted_resource_3]
  end
end
