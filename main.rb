require_relative 'model'
require 'pry'
require 'pry-byebug'

class Main
  def self.run
    products = Product.load_products()
    orders = Order.load_orders()

    invoices = Invoice.create_invoices(orders, products)
  end
end

Main.run
