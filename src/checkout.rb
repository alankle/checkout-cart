require 'rspec'

class PricingRule
  attr_accessor :code, :quantity, :price, :total

  def initialize; end

  def total_price
    @price = 4.5 if @code == :SR1 && @quantity >= 3

    @total = @price * @quantity

    @total -= @price if @code == :GR1 && @quantity >= 2

    [@code, @quantity, @price, @total]
  end
end

class Checkout
  ITEM = [
    QUANTITY = 1,
    TOTAL_PRICE = 3
  ].freeze

  attr_accessor :pricing_rules, :cart, :basket, :total_cart

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules

    @catalogue = {
      GR1: ['Green tea', 3.11],
      SR1: ['Strawberries', 5.00],
      CF1: ['Coffee', 11.23]
    }

    @cart = []
    @basket = {}
    @total_cart = []
  end

  def scan(item_code)
    @cart << item_code if @catalogue.key?(item_code.to_sym)
  end

  def total
    compute_quantities
    compute_total

    result = @total_cart.reduce(0) { |sum, item_line| sum + item_line[TOTAL_PRICE] }
    result.round(2)
  end

  private

  def compute_quantities
    @cart.each do |item_code|
      @basket[item_code.to_sym] = if @basket.key?(item_code.to_sym)
                                    @basket[item_code.to_sym] + 1
                                  else
                                    1
                                  end
    end
  end

  def compute_total
    @basket.each do |code, quantity|
      product = @catalogue[code]
      price = product[QUANTITY]

      @pricing_rules.code = code.to_sym
      @pricing_rules.quantity = quantity
      @pricing_rules.price = price

      @total_cart << @pricing_rules.total_price
    end
  end
end

describe Checkout do
  it 'Basket: GR1,SR1,GR1,GR1,CF1' do
    co = Checkout.new(PricingRule.new)
    co.scan('GR1')
    co.scan('SR1')
    co.scan('GR1')
    co.scan('GR1')
    co.scan('CF1')
    expect(co.total).to eq(22.45)
  end

  it 'Basket: GR1,GR1' do
    co = Checkout.new(PricingRule.new)
    co.scan('GR1')
    co.scan('GR1')
    expect(co.total).to eq(3.11)
  end

  it 'Basket: SR1,SR1,GR1,SR1' do
    co = Checkout.new(PricingRule.new)
    co.scan('SR1')
    co.scan('SR1')
    co.scan('GR1')
    co.scan('SR1')
    expect(co.total).to eq(16.61)
  end
end
