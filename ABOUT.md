## Ckeckout Cart

2 Classes are used in this exercice : 
- Checkout
- PricingRule
injection dependency is used in order to inject PrincingRule in Checkout

An harcoded Catalogue with Items data is initialized in the Checkout Constructor.
- @cart = [] represent an unordered list of scanned Items
- @basket = {} group scanned items stores by code item with the calculated quantity 
- @total_cart = [[code, quantity, price, total_price] is an array of array used to apply pricing rules and compute the  total cart

### private methods : 
compute_quantities : copy data from @cart to @basket in order to group items and compute quantities
compute_total :  take @basket then apply pricing rules and generate the final @total_cart
### public methods :
scan : check if the code item is present in the catalogue and add it to @cart
total : compute and return grand total


