require 'bigdecimal'
require_relative 'pack'

class ShippingPack
  attr_accessor :pack, :count

  def initialize(pack = nil, count = nil)
    validate!(pack, count)

    @pack = pack
    @count = count
  end

  def number_of_unit
    self.count * self.pack.number_of_unit
  end

  def price
    (BigDecimal(self.count.to_s) * BigDecimal(self.pack.price.to_s)).to_f
  end

  private

  def validate!(pack, count)
    raise ArgumentError.new("Pack should be an instance of Pack") unless pack.is_a?(Pack)
    raise ArgumentError.new("Count should be an integer") unless count.is_a?(Integer)
    raise ArgumentError.new("Cound should be greater than or equal 0") if count < 0
  end
end
