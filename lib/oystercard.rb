require_relative 'station'

class Oystercard
  attr_reader :balance, :limit, :entry_station, :exit_station, :journeys
  PENALTY = 6 
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @limit = MAX_BALANCE
    @journeys = []
  end
  
  def top_up(value)
    exceeded_balance_message(value)
    @balance += value
  end


  def tap_in(entry_station)
    unecessary_fund_message
    @trip = Journey.new 
    @trip.start_journey(entry_station) 
  end

  def tap_out(exit_station, fare = MIN_BALANCE)
    if @trip.nil? 
      @trip = Journey.new 
      deduct(PENALTY)
      @trip.finish_journey(exit_station)
    else
      deduct(MIN_BALANCE)
      @trip.finish_journey(exit_station)    
    end
    @journeys << @trip
  end

  def deduct(value)
    @balance -= value
  end
  
  def exceeded_balance_message(value)
    fail "Top-up limit of £#{@limit} exceeded" if (@balance + value) > @limit
  end
  
  def unecessary_fund_message
    fail "Mininum balance of £#{MIN_BALANCE} required to travel" if @balance < MIN_BALANCE
  end

end
