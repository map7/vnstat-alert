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

describe "#percentage_used" do
  context "given limit of 40" do
    context "usage of 20" do
      it "gives us 50" do
        percentage_used(40, 20).should eq(50)
      end
    end

    context "usage of 30" do
      it "gives us 75" do
        percentage_used(40,30).should eq(75)
      end
    end

    context "usage of 60" do
      it "gives us 150" do
        percentage_used(40, 60).should eq(150)
      end
    end
  end
end
