LIMIT = 90

class Oystercard
  attr_reader :balance, :limit, :in_use

  def initialize
    @balance = 0
    @limit = LIMIT
    @in_use = false
  end
  def top_up(value)
    projection = @balance + value
    raise "top up limit of #{LIMIT} exceeded" if projection > @limit
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
    @in_use = true
  end
  def tap_out
    @in_use = false
  end
end
