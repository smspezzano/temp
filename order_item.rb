# a specific item in an order
class OrderItem
  attr_reader :item, :count
  
  def initialize(item: , count:)
    @item = item
    @count = count
  end
end