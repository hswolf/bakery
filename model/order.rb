require 'yaml'

class Order
  attr_accessor :quantity, :code

  def initialize(quantity, code)
    @quantity = quantity
    @code = code
  end

  def self.load_orders(order_file)
    orders_reader = YAML.load_file(order_file)

    orders_reader.map do |order|
      new(order[:quantity], order[:code])
    end
  end
end