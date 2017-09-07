class ShippingPack
  attr_accessor :quantity, :pack

  def initialize(quantity, pack)
    @quantity = quantity
    @pack = pack
  end

  def self.create_shipping_packs(order_quantity, packs)
    array_of_possible_quantities_per_pack = packs.map do |pack|
      generate_possible_quantities_per_pack(order_quantity, pack)
    end

    binding.pry
  end

  def self.generate_possible_quantities_per_pack(order_quantity, pack)
    possible_quantities = [0]
    quantity = 1

    loop do
      possible_quantities << quantity

      break if quantity * pack.number_of_unit >= order_quantity
      quantity += 1
    end

    possible_quantities
  end
end