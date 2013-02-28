require_relative '../vnstat-alert'

describe "#monthly_used" do
  it "returns used amount for this month in GB" do
    pending
  end
end

describe "#MB_to_GB" do
  it "converts MegaBytes to GigaBytes" do
    MB_to_GB(3072).should eq(3)
  end

  it "converts 2000 to 2" do
    MB_to_GB(2000).should eq(2)
  end
end
