

class Oystercard
  attr_reader :balance, :limit, :in_use
  LIMIT = 90
  MIN_BALANCE = 1


  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
  end
  def top_up(value)
    projection = @balance + value
    fail "Top-up limit of £#{@limit} exceeded" if projection > @limit
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end
  #is it necessary to use both in_journey and in_use (they are both booleans showing the same thing)
  def in_journey?
    @in_use
  end

  def tap_in
    fail "Mininum balance of £#{MIN_BALANCE} required to travel" if @balance < MIN_BALANCE
    @in_use = true
  end

  def tap_out
    @in_use = false
  end

end
