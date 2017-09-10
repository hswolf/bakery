require 'benchmark'
require_relative 'model'

pack_hash = [
  { number_of_unit: 2, price: 6.99 },
  { number_of_unit: 7, price: 8.99 },
  { number_of_unit: 8, price: 10.99 }
]

product = Product.new(
  'Apple pie',
  'AP',
  pack_hash
)

Benchmark.bm do |bm|
  puts "Benchmark case 1"

  order = Order.new(65, 'AP')
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 2"

  order = Order.new(650, 'AP')
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 3"

  order = Order.new(6500, 'AP')
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 4"

  order = Order.new(65000, 'AP')
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 5"

  order = Order.new(6500, 'AP')
  pack_hash << { number_of_unit: 9, price: 10.99 }
  product = Product.new(
    'Apple pie',
    'AP',
    pack_hash
  )
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 6"
  pack_hash << { number_of_unit: 10, price: 10.99 }
  product = Product.new(
    'Apple pie',
    'AP',
    pack_hash
  )
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 7"
  pack_hash << { number_of_unit: 11, price: 10.99 }
  product = Product.new(
    'Apple pie',
    'AP',
    pack_hash
  )
  bm.report do
    Invoice.new(order, product)
  end

  puts "Benchmark case 8"
  pack_hash << { number_of_unit: 12, price: 10.99 }
  product = Product.new(
    'Apple pie',
    'AP',
    pack_hash
  )
  bm.report do
    Invoice.new(order, product)
  end
end