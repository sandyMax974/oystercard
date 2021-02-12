require 'oystercard'

describe Oystercard do
  let(:minimum_fare) { 1 }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

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

  describe '#touch_in' do
    it 'should take one argument' do
      expect(subject).to respond_to(:touch_in).with(1)
    end

    # should create a new instance of Journey with  one argument
    it 'should create a new Journey with one argument' do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      expect(Journey).to respond_to(:new).with(1)
    end

    it 'should fail if balance is less than 1' do
      message = "Mininum balance of £#{Oystercard::MIN_BALANCE} required to travel"
      expect { subject.touch_in(entry_station) }.to raise_error message
    end
  end

  describe '#touch_out' do
    # it 'should change in_journey? to false' do
    #   subject.top_up(20)
    #   subject.touch_in(entry_station)
    #   expect { subject.touch_out(exit_station, minimum_fare) }.to change { subject.in_journey? }.to false
    # end
    it 'should set entry_station to be nil' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station, minimum_fare)
      expect(subject.entry_station).to eq nil
    end
    it 'should set exit station' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station, minimum_fare)
      expect(subject.exit_station).to eq exit_station
    end
    it 'should store the entry and exit station in journeys' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station, minimum_fare)
      expect(subject.journeys_log).to include(journey)
    end

    it 'should deduct travel fare from card balance' do
      subject.top_up(20)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station, minimum_fare) }.to change { subject.balance }.to (subject.balance - minimum_fare)
    end
  end

end
