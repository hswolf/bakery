class ShippingPack
  attr_accessor :pack, :count

  def initialize(pack, count)
    @pack = pack
    @count = count
  end

  def self.create_shipping_packs(order_quantity, packs)
    sorted_packs = packs.sort_by { |pack| pack.number_of_unit }
    @@saved_array = {}
    x = best_shipping_packs(sorted_packs.size - 1, order_quantity, sorted_packs)
  end

  private

  def self.best_shipping_packs(last, quantity, packs)
    return 0 if quantity <= 0

    return new(packs[last], quantity / packs[last].number_of_unit) if last == 0

    saved_key = "#{last}|#{quantity}".to_sym

    if @@saved_array[saved_key].nil?
      quotient = quantity / packs[last].number_of_unit

      possible_packages = (0..quotient).map do |i|
        new_quantity = quantity - i * packs[last].number_of_unit
        shipping_pack = new(packs[last], i)

        [shipping_pack, best_shipping_packs(last - 1, new_quantity, packs)].flatten - [0]
      end

      @@saved_array[saved_key] = best_packages(possible_packages, quantity)
    end

    return @@saved_array[saved_key]
  end

  def self.best_packages(packages, quantity)
    return [] if packages.empty?

    packages.select { |package| package && !package.include?(false) && !package.include?(nil) }
      .sort { |first, second| Package.new(first, quantity) <=> Package.new(second, quantity) }
      .first
  end
end

class Package
  attr_accessor :shipping_packs, :demanded_quantity

  def initialize(shipping_packs, demanded_quantity)
    @shipping_packs = shipping_packs
    @demanded_quantity = demanded_quantity
  end

  def total_numb_of_pack
    self.shipping_packs.sum { |shipping_pack| shipping_pack.count }
  end

  def total_numb_of_unit
    self.shipping_packs.sum { |shipping_pack| shipping_pack.count * shipping_pack.pack.number_of_unit }
  end

  def total_price
    self.shipping_packs.sum { |shipping_pack| shipping_pack.count * shipping_pack.pack.price }
  end

  def different_to_demanded_quantity
    (total_numb_of_unit - self.demanded_quantity).abs
  end

  def <=>(another_package)
    return 0 if self.demanded_quantity != another_package.demanded_quantity


    if different_to_demanded_quantity < another_package.different_to_demanded_quantity
      return -1
    elsif different_to_demanded_quantity > another_package.different_to_demanded_quantity
      return 1
    end

    if total_numb_of_pack < another_package.total_numb_of_pack
      return -1
    elsif total_numb_of_pack > another_package.total_numb_of_pack
      return 1
    end

    if total_price < another_package.total_price
      return -1
    elsif total_price > another_package.total_price
      return 1
    end

    return 0
  end
end