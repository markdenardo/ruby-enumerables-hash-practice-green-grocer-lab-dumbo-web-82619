#require "pry"
def consolidate_cart(cart) 
  new_cart = {} 
  cart.each do |items_array| 
    items_array.each do |item, attribute_hash| 
      new_cart[item] ||= attribute_hash 
      new_cart[item][:count] ? new_cart[item][:count] += 1 :   
      new_cart[item][:count] = 1 
  end 
end 
new_cart 
end

def apply_coupons(cart, coupons) 
  coupons.each do |coupon| 
    # binding.pry
      name = coupon[:item] 
      if cart.has_key?(name)
        if cart[name][:count] >= coupon[:num] && !cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"] = {:price => coupon[:cost]/coupon[:num], :clearance => cart[name][:clearance], :count => coupon[:num]}
          cart[name][:count] -= coupon[:num] 
        elsif cart[name][:count] >= coupon[:num] && cart["#{name} W/COUPON"] 
          cart["#{name} W/COUPON"][:count] += coupon[:num]
          cart[name][:count] -= coupon[:num] 
        end 
      end
  end
  cart 
end

def apply_clearance(cart) 
  cart.each do |item, attribute_hash| 
    if attribute_hash[:clearance] == true 
      attribute_hash[:price] = (attribute_hash[:price] *
      0.8).round(2) 
    end 
  end 
cart 
end

def checkout(cart, coupons) 
  total = 0 
  new_cart = consolidate_cart(cart) 
  coupon_cart = apply_coupons(new_cart, coupons) 
  clearance_cart = apply_clearance(coupon_cart) 
  clearance_cart.each do |item, attribute_hash| 
    total += (attribute_hash[:price] * attribute_hash[:count])
  end 

total > 100 ? total * 0.90 : total

end