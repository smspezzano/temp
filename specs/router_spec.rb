require_relative './shared_context'
require_relative '../router'
require_relative '../pharmacy'
require_relative '../assignment'

RSpec.describe Router do
  include_context 'shared context'

  describe '#assign' do
    subject { described_class.new(sites: [pharmacy_1, pharmacy_2]) }
    
    it 'returns the pharamcy with the lowest overall cost' do
      expect(subject.assign(order: order).site).to eq(pharmacy_1)
    end

    context 'when shipping costs are not the same but inventory costs are' do
      let(:inventory_2) { Inventory.new(item: item_1, available: 2, cost: 5.0) }
      let(:pharmacy_2) { Pharmacy.new(stock: [inventory_2], shipping_fee: 10.0) }
      
      it 'returns the pharmacy with the lowest overall cost' do
        expect(subject.assign(order: order).site).to eq(pharmacy_1)
      end
    end

    context 'with multiple OrderItems' do
      let(:order_item_2) { OrderItem.new(item: item_2, count: 1) }
      let(:order) { Order.new(items: [order_item_1, order_item_2]) }
      let(:inventory_item_2) { Inventory.new(item: item_2, available: 2, cost: 10.0) }
      let(:pharmacy_1_inventory) { [inventory_1, inventory_item_2] }
      let(:pharmacy_2_inventory) { [inventory_1, inventory_item_2] }

      it 'returns the pharmacy with the lowest overall cost' do
        expect(subject.assign(order: order).site).to eq(pharmacy_1)
      end
    end

    context 'when no sites have the available items' do
      let(:pharmacy_1_inventory) { [] }
      let(:pharmacy_2_inventory) { [] }
      
      it 'raises an error' do
        expect{ subject.assign(order: order) }.to raise_error('Cannot fulfill order')
      end
    end
  end
end