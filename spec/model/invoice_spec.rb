require_relative '../../model/invoice'

RSpec.describe Invoice do
  context '#initialize' do
    subject { Invoice.new(order, product) }
    let(:order) { Order.new(65, 'AP') }
    let(:product) do
      Product.new(
       'Apple pie',
        'AP',
        [
          { number_of_unit: 2, price: 6.99 },
          { number_of_unit: 7, price: 8.99 },
          { number_of_unit: 8, price: 10.99 }
        ]
      )
    end

    context 'normal case' do
      it { is_expected.to be_instance_of(Invoice) }
    end

    context 'abnormal case' do
      context 'with order is not an instance of Order' do
        let(:order) { 1 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with product is not an instance of Product' do
        let(:product) { 1 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with product is nil' do
        let(:product) { nil }

        it { is_expected.to be_instance_of(Invoice) }
      end
    end
  end
end