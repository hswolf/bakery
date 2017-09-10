class Pack
  attr_accessor :number_of_unit, :price

  def initialize(number_of_unit = 0, price = 0)
    validate!(number_of_unit, price)

    @number_of_unit = number_of_unit
    @price = price
  end

  private

  def validate!(number_of_unit, price)
    raise ArgumentError.new("Number of unit should be an integer") unless number_of_unit.is_a?(Integer)
    raise ArgumentError.new("Number of unit should be greater than 0") if number_of_unit <= 0
    raise ArgumentError.new("Price should be present") if price.nil?
    raise ArgumentError.new("Price should be greater than 0") if price <= 0
  end
end