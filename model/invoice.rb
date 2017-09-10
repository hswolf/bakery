require_relative 'product'
require_relative 'order'
require_relative 'shipping_pack'
require 'bigdecimal'

class Invoice
  attr_accessor :order, :shipping_packs

  def initialize(order = nil, product = nil)
    validate!(order, product)

    @order = order

    @shipping_packs = if product.nil?
      false
    else
      best_shipping_packs(product.packs.size - 1, order.quantity, product.packs) || false
    end
  end

  def self.create_invoices(orders, products)
    invoices = []

    orders.each do |order|
      product = Product.find_product_by_code(products, order.code)

      invoices << new(order, product)
    end

    invoices
  end

  def total_price
    return unless self.shipping_packs
    calculate_total_price(self.shipping_packs)
  end

  def total_pack
    return unless self.shipping_packs
    calculate_total_pack(self.shipping_packs)
  end

  private

  def validate!(order, product)
    raise ArgumentError.new("Order must be an instance of Order") unless order.is_a?(Order)

    unless product.nil? || product.is_a?(Product)
      raise ArgumentError.new("Product must be nil or an instance of Product")
    end
  end

  # Finding best package from an array of packages
  # @param packages [Array[Array[ShippingPack]]]
  # @param quantity [Integer]
  def best_package(packages, quantity)
    return false if packages.empty?

    packages
      .compact
      .reject { |package| package.include?(false) || package.include?(nil) }
      .sort { |first, second| calculate_total_pack(first) <=> calculate_total_pack(second) }
      .first
  end

  def calculate_total_pack(shipping_packs)
    shipping_packs.sum { |shipping_pack| shipping_pack.count }
  end

  def calculate_total_price(shipping_packs)
    shipping_packs.sum { |shipping_pack| BigDecimal(shipping_pack.price.to_s) }.to_f
  end

  def quotient_and_remain(dividend, divisor)
    [
      dividend / divisor,
      dividend % divisor
    ]
  end

  def best_shipping_packs(last, quantity, packs, saved_shipping_packs = {})
    return false if quantity < 0
    return [] if quantity == 0

    quotient, remain = quotient_and_remain(quantity, packs[last].number_of_unit)

    return false if last == 0 && remain != 0
    return ShippingPack.new(packs[last], quantity / packs[last].number_of_unit) if last == 0

    saved_key = "#{last}|#{quantity}".to_sym

    return saved_shipping_packs[saved_key] unless saved_shipping_packs[saved_key].nil?

    possible_packages = (0..quotient).map do |i|
      new_quantity = quantity - i * packs[last].number_of_unit
      shipping_pack = ShippingPack.new(packs[last], i)

      [
        shipping_pack,
        best_shipping_packs(last - 1, new_quantity, packs, saved_shipping_packs)
      ].flatten
    end

    saved_shipping_packs[saved_key] = best_package(possible_packages, quantity)
  end
end
