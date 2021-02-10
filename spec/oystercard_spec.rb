require 'oystercard'

describe Oystercard do
  let(:minimum_fare) { 1 }

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
      oyster = Oystercard.new
      oyster.top_up(Oystercard::LIMIT)
      expect { oyster.top_up(1) }.to raise_error "Top-up limit of £#{Oystercard::LIMIT} exceeded"
    end
  end

  # describe '#deduct' do
  #   it 'should deduct from the balance on the card' do
  #     subject.deduct(10)
  #     # allow(subject).to receive(:deduct) { 10 }
  #     expect(subject.balance).to eq (-10)
  #   end
  # end
  describe '#in_journey?' do
    it 'should return false if the oystercard isnt in use' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#tap_in' do
    it 'should change in_journey? to true' do
      subject.top_up(20)
      expect{subject.tap_in}.to change{subject.in_journey?}.to true
    end
    it 'should fail if balance is less than 1' do
      expect { subject.tap_in }.to raise_error "Mininum balance of £#{Oystercard::MIN_BALANCE} required to travel"
    end
  end

  describe '#tap_out' do
    it 'should change in_journey? to false' do
      subject.top_up(20)
      subject.tap_in
      expect { subject.tap_out(minimum_fare) }.to change { subject.in_journey? }.to false
    end
    it 'should deduct travel fare from card balance' do
      subject.top_up(20)
      subject.tap_in
      expect { subject.tap_out(minimum_fare) }.to change { subject.balance }.to (subject.balance - minimum_fare)
    end
  end

end
