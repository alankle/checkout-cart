# checkout-cart
## Shopping cart exercice

### Sample Rspec test : 
    it 'Basket: GR1,SR1,GR1,GR1,CF1' do
      co = Checkout.new(PricingRule.new)
      co.scan('GR1')
      co.scan('SR1')
      co.scan('GR1')
      co.scan('GR1')
      co.scan('CF1')
      expect(co.total).to eq(22.45)
    end

