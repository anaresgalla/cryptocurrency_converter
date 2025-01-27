# Coin class to save each crypto coin price

class Coin 
  attr_accessor :symbol, :USD, :BRL, :EUR

  def initialize(symbol, usd, brl, eur)
    @symbol, @USD, @EUR, @BRL = symbol, usd, eur, brl
  end
end
