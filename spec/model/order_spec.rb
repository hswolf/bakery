require_relative '../../model/order.rb'

RSpec.describe Order, '#new' do
  subject { Order.new(quantity, code) }
  let(:quantity) { 1 }
  let(:code) { 'VS' }

  context 'normal case' do
    it { is_expected.to be_instance_of(Order) }
  end

  context 'abnormal case' do
    context 'with quantity is not an integer' do
      let(:quantity) { 1.2 }

      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'with quantity is zero' do
      let(:quantity) { 0 }

      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'with quantity is less than zero' do
      let(:quantity) { -1 }

      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'with code is blank' do
      let(:code) {}

      it 'should raise error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
