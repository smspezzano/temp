require_relative '../order_item'
require_relative '../order'
require_relative '../inventory'
require_relative '../pharmacy'

RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "shared context", :shared_context => :metadata do
  let(:item_1) { 'prescription_a' }
  let(:item_2) { 'prescription_b' }

  let(:order_item_1) { OrderItem.new(item: item_1, count: 1) }

  let(:order) { Order.new(items: [order_item_1]) }

  let(:inventory_1) { Inventory.new(item: item_1, available: 2, cost: 5.0) }
  let(:inventory_2) { Inventory.new(item: item_1, available: 2, cost: 10.0) }
  let(:empty_inventory) { Inventory.new(item: item_1, available: 0, cost: 5.0) }
  let(:pharmacy_1_inventory) { [inventory_1] }
  let(:pharmacy_2_inventory) { [inventory_1] }

  let(:pharmacy_1) { Pharmacy.new(stock: pharmacy_1_inventory, shipping_fee: 5.0) }
  let(:pharmacy_2) { Pharmacy.new(stock: pharmacy_2_inventory, shipping_fee: 5.0) }
end

RSpec.configure do |rspec|
  rspec.include_context "shared context", :include_shared => true
end