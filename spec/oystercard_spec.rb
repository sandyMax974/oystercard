require 'oystercard'

describe Oystercard do
  let(:minimum_fare) { 1 }
  let(:entry_station) { double(:station) }
  let(:station) { double(:station)}

  it 'has a balance of 0 by default' do
    expect(subject.balance).to eq(0)
  end
  it 'has a limit' do
    expect(subject.limit).to eq(90)
  end

  describe '#top_up' do
    it 'should take a top-up value and add it to the card balance' do
      subject.top_up(10)
      expect(subject.balance).to eq (10)
    end
    it 'should raise an error if top_up returns more than 90' do
      oyster = Oystercard.new
      message = "Top-up limit of £#{Oystercard::MAX_BALANCE} exceeded"
      oyster.top_up(Oystercard::MAX_BALANCE)
      expect { oyster.top_up(1) }.to raise_error message
    end
  end


  describe '#in_journey?' do
    it 'should return false if the oystercard isnt in use' do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#tap_in' do
    it 'should take one argument' do
      expect(subject).to respond_to(:tap_in).with(1)
    end
    it 'should store an entry_station to the card' do
      subject.top_up(20)
      subject.tap_in(entry_station)
      expect(subject.entry_station).to be(entry_station)
    end
    it 'should change in_journey? to true' do
      subject.top_up(20)
      expect{subject.tap_in(entry_station)}.to change{subject.in_journey?}.to true
    end
    it 'should fail if balance is less than 1' do
      message = "Mininum balance of £#{Oystercard::MIN_BALANCE} required to travel"
      expect { subject.tap_in(entry_station) }.to raise_error message
    end
  end

  describe '#tap_out' do
    it 'should change in_journey? to false' do
      subject.top_up(20)
      subject.tap_in(entry_station)
      expect { subject.tap_out(minimum_fare) }.to change { subject.in_journey? }.to false
    end
    it 'should set entry_station to be nil' do
      subject.top_up(20)
      subject.tap_in(entry_station)
      subject.tap_out(minimum_fare)
      expect(subject.entry_station).to eq nil
    end
    it 'should deduct travel fare from card balance' do
      subject.top_up(20)
      subject.tap_in(entry_station)
      expect { subject.tap_out(minimum_fare) }.to change { subject.balance }.to (subject.balance - minimum_fare)
    end
  end

end
