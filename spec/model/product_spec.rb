require_relative '../../model/product'

RSpec.describe Product do
  context '#initialize' do
    subject { Product.new(name, code, packs) }
    let(:name) { 'Apple pie' }
    let(:code) { 'AP' }
    let(:packs) { [{number_of_unit: 1, price: 1}] }

    context 'normal case' do
      it { is_expected.to be_instance_of(Product) }
    end

    context 'abnormal case' do
      context 'with name is not present' do
        let(:name) {}

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with code is not present' do
        let(:code) {}

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'packs is not an Array' do
        let(:packs) {}

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'packs is not an Array of Hash' do
        let(:packs) { [1] }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end