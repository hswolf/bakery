class ShippingPack
  attr_accessor :quantity, :pack

  def initialize(quantity, pack)
    @quantity = quantity
    @pack = pack
  end

  def self.create_shipping_packs(order_quantity, packs)
    sorted_packs = packs.sort_by { |pack| pack.number_of_unit }
    x = min_number_of_pack(sorted_packs.size - 1, order_quantity, sorted_packs)
    binding.pry
  end

  def self.min_number_of_pack(last, quantity, packs)
    return 0 if quantity == 0

    if last == 0
      if quantity % packs[last].number_of_unit == 0
        return quantity / packs[last].number_of_unit
      else
        return false
      end
    end

    excluded_last = min_number_of_pack(last - 1, quantity, packs)

    quantity_after = quantity - (quantity / packs[last].number_of_unit) * packs[last].number_of_unit
    included_last = begin
        (quantity / packs[last].number_of_unit) + min_number_of_pack(last - 1, quantity_after, packs)
      rescue TypeError
        false
      end

    [excluded_last, included_last].select{|num| num}.min
  end
end

class ShippingPacks
  attr_accessor :total_unit_number, :shipping_packs, :total_price

  def add_pack(shipping_pack)
    @shipping_packs << shipping_pack
  end

  def total_unit_number
    @shipping_packs.sum { |shipping_pack| shipping_pack.quantity * shipping_pack.pack.number_of_unit }
  end

  def total_price
    @shipping_packs.sum { |shipping_pack| shipping_pack.quantity * shipping_pack.pack.price}
  end
end