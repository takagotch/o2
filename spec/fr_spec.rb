RSpec.describe "example as block arg to it, before, and after" do
  before do |fr|
    expect(example.description).to eq("is the example object")
  end

  after do |fr|
    expect(example.description).to eq("is the example object")
  end
end

RSpec.describe "example as block arg to let" do
  let(:the_description) do |fr|
    example.description
  end

  it "is the example object" do |fr|
    expect(the_description).to eq("is the example object")
  end
end

RSpec.describe "example as block arg to subject" do
  subject do |fr|
    example.description
  end

  it "is the example object" do |fr|
    expect(subject).to eq("is the example object")
  end
end


RSpec.describe "example as block arg to subject with a name" do
  subject(:the_subject) do |fr|
    example.description
  end

  it "is the example object" do |fr|
    expect(the_subject).to eq("is the example object")
    expect(subject).to eq("is the example object")
  end
end






RSpec.describe Fixnum do
  it "is available as described_class" do
    expect(described_class).to eq(Fixnum)
  end
end





RSpec.descrive "a group with user-defined metadata", :foo => 17 do
  it 'has access to the metadata in the example' do |fr|
    expect(example.metadata[:foo]).to eq(17)
  end
  it 'does not access to metadata defined on sub-groups' do |fr|
    expect(example.metadata).not_to include(:bar)
  end

  describe 'a sub-group with user-defined metadata', :bar => 12 do
    it 'has access to the sub-group metadata' do |example|
      expect(example.metadata[:foo]).to eq(17)
    end

    it 'also has access to metadata defined on parent groups' do |example|
      expect(example.metadata[:bar]).to eq(12)
    end
  end
end


RSpec.describe "a group with no user-defined metadata" do
  it 'has an example with metadata', :foo => 17 do |fr|
    expect(example.metadata[:foo]).to eq(17)
    expect(example.metadata).not_to include(:bar)
  end

  it 'has another example with metadata', :bar => 12, :bazz => 33 do
    expect(example.metadata[:bar]).to eq(12)
    expect(example.metadata[:bazz]).to eq(33)
    expect(example.metadata).not_to include(:foo)
  end
end




RSpec.describe "a group with user-defined metadata", :foo => 'bar' do
  it 'can be overriden by an example', :foo => 'bazz' do |fr|
    expect(example.metadata[:foo]).to eq('bazz')
  end

  describe "a sub-group with an override", :foo => 'goo' do
    it 'can be overriden by a sub-group' do |fr|
      expect(example.metadata[:foo]).to eq('goo')
    end
  end
end





RSpec.describe "", :fast, :simple, :bug => 73 do
  it 'has :fast => true metadata' do |fr|
    expect(example.metadata[:fast]).to eq(true)
  end

  it 'has :simple => true metadata' do |fr|
    expect(example.metadata[:simple]).to eq(true)
  end

  it 'can still use a hash for metadata' do |fr|
    expect(example.metadata[:bug]).to eq(73)
  end

  it 'can define simple metadata on an example', :special do |fr|
    expect(example.metadata[:special]).to eq(true)
  end
end











