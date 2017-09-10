require 'yaml'
require_relative 'pack'

class Product
  attr_accessor :name, :code, :packs

  def initialize(name = nil, code = nil, packs = nil)
    validate!(name, code, packs)

    @name = name
    @code = code
    @packs = packs.map { |pack| Pack.new(pack[:number_of_unit], pack[:price]) }
                  .sort_by { |pack| pack.number_of_unit }
  end

  def self.find_product_by_code(products, code)
    products.find { |product| product.code.downcase == code.downcase }
  end

  def self.load_products(product_file)
    products_reader = YAML.load_file(product_file)

    products_reader.map do |product|
      new(product[:name], product[:code], product[:packs])
    end
  rescue Errno::ENOENT
    puts "Sorry. We cannot find your 'product' file."
  end

  private

  def validate!(name, code, packs)
    raise ArgumentError.new("Name should be present.") if name.nil?
    raise ArgumentError.new("Code should be present.") if code.nil?
    unless packs.is_a?(Array) && packs.all?{ |pack| pack.is_a?(Hash) }
      raise ArgumentError.new("Packs should be an Array of Hash")
    end
  end
end