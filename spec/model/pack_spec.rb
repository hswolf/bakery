require_relative '../../model/pack'

RSpec.describe Pack do
  context '#initialize' do
    subject { Pack.new(number_of_unit, price) }
    let(:number_of_unit) { 10 }
    let(:price) { 20.5 }

    context 'normal case' do
      it { is_expected.to be_instance_of(Pack) }
    end

    context 'abnormal case' do
      context 'with number_of_unit is not an integer' do
        let(:number_of_unit) { 1.2 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with number_of_unit is less than 0' do
        let(:number_of_unit) { -1 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with price is not present' do
        let(:price) {}

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end

      context 'with price is less than 0' do
        let(:price) { -1 }

        it 'should raise error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end
end