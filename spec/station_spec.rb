require 'station'

describe Station do
  subject { described_class.new("old street", 1) }

  it 'should have a name' do
    expect(subject.name).to eq("old street")
  end
  it 'should have a zone' do
    expect(subject.zone).to eq(1)
  end
end
