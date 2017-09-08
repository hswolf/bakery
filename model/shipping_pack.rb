class ShippingPack
  attr_accessor :quantity, :pack

  def initialize(quantity, pack)
    @quantity = quantity
    @pack = pack
  end

  def self.create_shipping_packs(order_quantity, packs)
    sorted_packs = packs.sort_by { |pack| pack.number_of_unit }
    @@saved_array = {}
    x = best_shipping_packs(sorted_packs.size - 1, order_quantity, sorted_packs)
    binding.pry
  end

  private

  def self.best_shipping_packs(last, quantity, packs)
    if quantity == 0
      return 0
    end

    if last == 0
      if quantity % packs[last].number_of_unit == 0
        return new(quantity / packs[last].number_of_unit, packs[last])
      else
        return false
      end
    end

    saved_key = "#{last}|#{quantity}".to_sym

    if @@saved_array[saved_key].nil?
      quotient = quantity / packs[last].number_of_unit

      possible_shipping_pack_arrays = (0..quotient).map do |i|
        new_quantity = quantity - i * packs[last].number_of_unit
        shipping_pack = new(i, packs[last])

        [shipping_pack, best_shipping_packs(last - 1, new_quantity, packs)].flatten - [0]
      end

      @@saved_array[saved_key] = select_min_in_shipping_pack_arrays(possible_shipping_pack_arrays)
    end

    return @@saved_array[saved_key]
  end

  def self.select_min_in_shipping_pack_arrays(arrays)
    return [] if arrays.empty?

    arrays.select { |arr|  arr && !arr.include?(false) && !arr.include?(nil) }
      .sort { |first, second| total_pack_of_shipping_packs(first) <=> total_pack_of_shipping_packs(second) }
      .first
  end

  def self.total_pack_of_shipping_packs(shipping_packs)
    (shipping_packs - [0]).sum { |shipping_pack| shipping_pack.quantity }
  end
end
