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
end
