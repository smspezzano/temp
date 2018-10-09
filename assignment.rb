# class to record which pharmacy will be used to fulfill an order
class Assignment
  attr_reader :order, :site

  def initialize(order:, site:)
    @order = order
    @site = site
  end
end