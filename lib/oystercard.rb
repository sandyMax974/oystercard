LIMIT = 90

class Oystercard
  attr_reader :balance, :limit

  def initialize
    @balance = 0
    @limit = LIMIT
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
    return false
  end

  def tap_in

  end

end
