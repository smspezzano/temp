# class to hold OrderItems in an order
class Order
  attr_accessor :items

  def initialize(items:)
    @items = items
  end
end