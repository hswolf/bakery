require_relative '../../model'

RSpec.describe 'Application receive Orders' do
  products = [ Product.new(
   'Apple pie',
    'AP',
    [
      { number_of_unit: 2, price: 6.99 },
      { number_of_unit: 7, price: 8.99 },
      { number_of_unit: 8, price: 10.99 }
    ]
  ),
  Product.new(
    'Vegemite Scroll',
    'VS5',
    [
      { number_of_unit: 3, price: 6.99 },
      { number_of_unit: 5, price: 8.99 }
    ]
  )]


  context 'with appropriate products and quantities' do
    it 'should return best Invoices (1)' do
      orders = [Order.new(65, 'AP')]
      expect(Invoice.create_invoices(orders, products).first.total_price).to eq 84.91
    end

    it 'should return best Invoices (2)' do
      orders = [Order.new(64, 'AP')]
      expect(Invoice.create_invoices(orders, products).first.total_price).to eq 87.92
    end

    it 'should return best Invoices (3)' do
      orders = [Order.new(43, 'AP')]
      expect(Invoice.create_invoices(orders, products).first.total_price).to eq 55.94
    end

    it 'should return best Invoices (4)' do
      orders = [Order.new(43, 'AP'), Order.new(10, 'VS5')]
      expect(Invoice.create_invoices(orders, products).map(&:total_price)).to eq [55.94, 17.98]
    end
  end

  context 'with wrong products' do
    it 'should return false' do
      orders = [Order.new(53, 'APP')]
      expect(Invoice.create_invoices(orders, products).first.shipping_packs).to eq false
    end
  end

  context 'with wrong quantities' do
    it 'should return false' do
      orders = [Order.new(1, 'AP')]
      expect(Invoice.create_invoices(orders, products).first.shipping_packs).to eq false
    end
  end
end