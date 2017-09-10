require_relative 'model'
require_relative 'output'

PRODUCT_FILE = 'products.yml'
INPUT_FILE = 'input.yml'
OUTPUT_FILE = 'output'

class Main
  def self.run
    products = Product.load_products(PRODUCT_FILE)
    orders = Order.load_orders(INPUT_FILE)

    invoices = Invoice.create_invoices(orders, products)

    Output.write_to_file(invoices, OUTPUT_FILE)
  end
end

Main.run
