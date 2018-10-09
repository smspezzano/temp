require_relative './shared_context'
require_relative '../pharmacy'

RSpec.describe Pharmacy do
  include_context 'shared context'

  describe '#estimate_shipping' do
    subject { described_class.new(stock: [inventory_1], shipping_fee: 5.0) }
    
    it 'returns a cost based on passed Order' do
      expect(subject.estimate_shipping(order: order_1)).to eq(5.0)
    end

    context 'when there is not enough inventory' do
      subject { described_class.new(stock: [empty_inventory], shipping_fee: 5.0) }

      it 'raises an error' do
        expect{ subject.estimate_shipping(order: order_1) }.to raise_error('Cannot ship because some items are not available at this Pharmacy')
      end
    end

    context 'when items exceed box limit' do
      let(:order_item_1) {OrderItem.new(item: item_1, count: 2) }

      it 'returns a 2x shipping cost' do
        stub_const("Pharmacy::BOX_LIMIT", 1.0)
        expect(subject.estimate_shipping(order: order_1)).to eq(10.0)
      end
    end
  end
end