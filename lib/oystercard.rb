

class Oystercard
  attr_reader :balance, :limit, :entry_station, :exit_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @limit = MAX_BALANCE
  end
  def top_up(value)
    exceeded_balance_message(value)
    @balance += value
  end
  def in_journey?
    !!@entry_station
  end

  def tap_in(station)
    unecessary_fund_message
    @entry_station = station
  end

  def tap_out(fare, station)
    @entry_station = nil
    deduct(fare)
    @exit_station = station
  end

  private

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
