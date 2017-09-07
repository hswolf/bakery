class Pack
  attr_accessor :number_of_unit, :price

  def initialize(number_of_unit, price)
    @number_of_unit = number_of_unit
    @price = price
  end
end