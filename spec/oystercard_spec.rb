require 'oystercard'

describe Oystercard do
  it 'has a balance of 0 by default' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'should take a top-up value and add it to the card balance' do
      subject.top_up(10)
      expect(subject.balance).to eq (10)
    end
  end
end
