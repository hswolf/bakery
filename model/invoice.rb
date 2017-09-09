require_relative 'product'
require_relative 'shipping_pack'
require 'bigdecimal'
require 'benchmark'

class Invoice
  attr_accessor :order, :total_price, :shipping_packs

  def initialize(order, product)
    @order = order
    puts Benchmark.measure{ShippingPack.create_shipping_packs(order.quantity, product.packs)}
    # @shipping_packs = ShippingPack.create_shipping_packs(order.quantity, product.packs)
    # @total_price = calculate_total_price(@shipping_packs)
  end

  def self.create_invoices(orders, products)
    invoices = []

    orders.each do |order|
      product = Product.find_product_by_code(products, order.code)

      invoices << new(order, product)
    end

    invoices
  end

  private

  def calculate_total_price(shipping_packs)
    bigdecimal_total = shipping_packs.sum do |shipping_pack|
      shipping_pack.quantity * BigDecimal(shipping_pack.pack.price.to_s)
    end

    bigdecimal_total.to_s
  end
end