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
  def in_journey?
    @in_use
  end
  def tap_in
    @in_use = true
  end

end
