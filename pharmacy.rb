require_relative 'inventory'
require 'pry'

class Pharmacy
  attr_accessor :stock
  attr_reader :shipping_fee

  BOX_LIMIT = 5.0

  def initialize(stock: [], shipping_fee: Rand.rand(10))
    @stock = stock
    @shipping_fee = shipping_fee
  end

  # order: list of OrderItems
  # returns: cost of shipping an order
  def estimate_shipping(order:)
    raise 'Cannot ship because some items are not available at this Pharmacy' unless all_items_present?(order: order)
    boxes = (order.items.sum(&:count) / BOX_LIMIT).ceil
    boxes * shipping_fee
  end


  def all_items_present?(order:)
    order.items.all? do |order_item|
      return false unless (stock_item = stock.find { |stock_item| stock_item.item === order_item.item })
      return true if stock_item.available >= order_item.count
    end
  end
end