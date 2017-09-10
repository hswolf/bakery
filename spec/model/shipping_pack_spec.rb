require_relative '../../model/shipping_pack'

RSpec.describe ShippingPack do
  context '#initialize' do
    subject { ShippingPack.new(pack, count) }
    let(:pack) { Pack.new(1, 10) }
    let(:count) { 20 }

    context 'normal case' do
      it { is_expected.to be_instance_of(ShippingPack) }
    end

    context 'abnormal case' do
      context 'with pack is not an istance of Pack' do
        let(:pack) { 1.2 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with count is not an integer' do
        let(:count) { 1.2 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with count is less than 0' do
        let(:count) { -1 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end