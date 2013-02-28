require_relative '../vnstat-alert'

describe "#monthly_used" do
  before do
    @data = <<-eos
d;28;1359550800;1335;838;544;1006;1
d;29;1359464400;955;295;504;671;1
m;0;1359637200;88304;14110;226;991;1
m;1;1356958800;20086;6575;77;796;1
eos
  end

  it "returns used amount for this month in GB" do
    monthly_used(@data).should eq(87)
  end
end

describe "#MB_to_GB" do
  it "converts MegaBytes to GigaBytes" do
    MB_to_GB(3072).should eq(3)
  end

  it "converts 2000 to 2" do
    MB_to_GB(2000).should eq(2)
  end

  it "rounds the figure up" do
    MB_to_GB(1025).should eq(2)
  end
end
