require 'journey'

describe Journey do
  let(:station) { double }
  # take on arg on initialize
  it 'takes the entry station as a argument when created' do
    expect(Journey).to respond_to(:new).with(1)
  end
  it 'should know the entry station' do
    expect(subject.entry_station).to be_nil
  end

  describe '#in_journey?' do
    it 'should know when we are in a journey' do
      my_trip = Journey.new(station)
      expect(my_trip.in_journey?).to be true
    end
  end
end
