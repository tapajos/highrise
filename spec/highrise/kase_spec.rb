require 'spec_helper'

describe Highrise::Kase do
  it { subject.should be_a_kind_of Highrise::Subject }
  
  it "#close!" do
    mocked_now = Time.parse("Wed Jan 14 15:43:11 -0200 2009")
    Time.should_receive(:now).and_return(mocked_now)
    subject.should_receive(:update_attribute).with(:closed_at, mocked_now.utc)
    subject.close!
  end

  it "#open!" do
    subject.should_receive(:update_attribute).with(:closed_at, nil)
    subject.open!
  end
end
