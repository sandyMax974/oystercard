require 'oystercard'

describe Oystercard do
  it 'has a balance of 0 by default' do
    expect(subject.balance).to eq(0)
  end
  it 'has a limit' do
    expect(subject.limit).to eq(90)
  end
  it 'has an `in_use` status of false' do
    expect(subject.in_use).to be false
  end

  describe '#top_up' do
    it 'should take a top-up value and add it to the card balance' do
      subject.top_up(10)
      expect(subject.balance).to eq (10)
    end
    it 'should raise an error if top_up returns more than 90' do
      expect { subject.top_up(91) }.to raise_error("top up limit of #{LIMIT} exceeded")
    end
  end

  describe '#deduct' do
    it 'should deduct from the balance on the card' do
      subject.deduct(10)
      expect(subject.balance).to eq (-10)
    end
  end
  describe '#in_journey?' do
    it 'should return false if the oystercard isnt in use' do
      expect(subject.in_journey?).to eq false
    end
  #  it 'should return true if the oystercard is in use' do
  #    expect(subject.in_journey?).to eq true
  #  end
  end

  describe '#tap_in' do
    it 'should change in_journey? to true' do
      expect{subject.tap_in}.to change{subject.in_journey?}.to true
    end
  end

end
