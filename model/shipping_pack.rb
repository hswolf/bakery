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

  private

  def self.min_number_of_pack(last, quantity, packs)
    return 0 if quantity == 0

    if last == 0
      if quantity % packs[last].number_of_unit == 0
        return new(quantity / packs[last].number_of_unit, packs[last])
      else
        return false
      end
    end

    excluded_last = [min_number_of_pack(last - 1, quantity, packs)].flatten

    quantity_after = quantity - (quantity / packs[last].number_of_unit) * packs[last].number_of_unit
    pack_quantity_after = new(quantity / packs[last].number_of_unit, packs[last])
    included_last = [
      pack_quantity_after,
      min_number_of_pack(last - 1, quantity_after, packs)
    ].flatten

    select_min_from_shipping_pack_arrays(excluded_last, included_last)
  end

  def self.select_min_from_shipping_pack_arrays(first, second)
    first_total_pack = total_pack_of_shipping_packs(first)
    second_total_pack = total_pack_of_shipping_packs(second)

    if first_total_pack && second_total_pack
      return first_total_pack < second_total_pack ? first : second
    end
    return first if first_total_pack
    return second if second_total_pack

    [false]
  end

  def self.total_pack_of_shipping_packs(shipping_packs)
    return false if shipping_packs.include?(false)
    (shipping_packs - [0]).sum { |shipping_pack| shipping_pack.quantity }
  end
end
