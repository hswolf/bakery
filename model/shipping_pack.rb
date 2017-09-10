require 'bigdecimal'

class ShippingPack
  attr_accessor :pack, :count

  def initialize(pack, count)
    @pack = pack
    @count = count
  end

  def number_of_unit
    self.count * self.pack.number_of_unit
  end

  def price
    (BigDecimal(self.count.to_s) * BigDecimal(self.pack.price.to_s)).to_f
  end
end
