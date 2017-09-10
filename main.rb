require 'optparse'
require_relative 'model'
require_relative 'output'
require 'pry'

PRODUCT_FILE = 'product.yml'
INPUT_FILE = 'input.yml'
OUTPUT_FILE = 'output'

class Main
  def self.run(options = {})
    products = Product.load_products(options[:product] || PRODUCT_FILE)
    orders = Order.load_orders(options[:input] || INPUT_FILE)

    return if products.nil? || orders.nil?

    invoices = Invoice.create_invoices(orders, products)

    Output.write_to_file(invoices, options[:output] || OUTPUT_FILE)
  end
end

options = {}

OptionParser.new do |parser|
  parser.banner = "Usage: hello.rb [options]"

  parser.on("-h", "--help", "Show this help message") do ||
    puts parser
  end

  parser.on("-p", "--product PRODUCT", "Path to product data.") do |v|
    options[:product] = v
  end

  parser.on("-i", "--input INPUT", "Path to order data.") do |v|
    options[:input] = v
  end

  parser.on("-o", "--output OUTPUT", "Path to output file.") do |v|
    options[:output] = v
  end
end.parse!

Main.run(options)
