require 'yaml'

class Order
  attr_accessor :quantity, :code

  def initialize(quantity = 0, code = nil)
    @quantity = quantity
    @code = code

    validate!
  end

  def self.load_orders(order_file)
    orders_reader = YAML.load_file(order_file)

    orders_reader.map do |order|
      new(order[:quantity], order[:code])
    end
  rescue Errno::ENOENT
    puts "Sorry. We cannot find your input file."
  end

  private

  def validate!
    raise ArgumentError.new("Quantity must be an integer") unless @quantity.is_a?(Integer)
    raise ArgumentError.new("Quantity must greater than 0") if @quantity <= 0
    raise ArgumentError.new("Code must be present") if @code.nil?
  end
end