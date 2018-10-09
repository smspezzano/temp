# class that describes an items cost and how many are currently available
class Inventory
  attr_reader :item, :cost
  attr_accessor :available

  def initialize(item:, available:, cost:)
    @item      = item
    @available = available
    @cost      = cost
  end
end