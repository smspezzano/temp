# class to handle assigning customer orders to a pharmacy
class Router
  attr_reader :sites
  attr_accessor :sites_with_order_items, :order

  def initialize(sites:)
    @sites = sites
  end

  # order: containts a list of OrderItems
  # returns: an Assignment
  def assign(order:)
    @order = order
    raise 'Cannot fulfill order' if sites_with_order_items.empty?
    Assignment.new(site: cost_per_site.first, order: order)
  end

  private
  
  def sites_with_order_items
    @sites_with_order_items ||= sites.select { |pharmacy| pharmacy.all_items_present?(order: order) }
  end

  def cost_per_site
    sites_with_order_items.sort_by { |pharmacy| cost_per_prder(pharmacy: pharmacy) }
  end

  def cost_per_prder(pharmacy:)
    items_cost = order.items.reduce(0) do |sum, order_item|
      sum + pharmacy.stock.find { |stock_item| stock_item.item === order_item.item }.cost
    end
    items_cost + pharmacy.estimate_shipping(order: order)
  end

end