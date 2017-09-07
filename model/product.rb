require 'yaml'
require_relative 'pack'

class Product
  PRODUCT_FILE = 'products.yml'

  attr_accessor :name, :code, :packs

  def initialize(name, code, packs)
    @name = name
    @code = code
    @packs = packs.map do |pack|
      Pack.new(pack[:number_of_unit], pack[:price])
    end
  end

  def self.find_product_by_code(products, code)
    products.find { |product| product.code == code }
  end

  def self.load_products(product_file = PRODUCT_FILE)
    products_reader = YAML.load_file(product_file)

    products_reader.map do |product|
      new(product[:name], product[:code], product[:packs])
    end
  end
end