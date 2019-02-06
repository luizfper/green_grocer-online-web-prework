require 'pry'

cartao = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

def consolidate_cart(cart)
  fin_array={}

  cart.each do |fruit|
    fruit.each do |k,v|
      #binding.pry
      if fin_array.keys.include?(k)
        #binding.pry
        fin_array[k][:price]=v[:price]
        fin_array[k][:count]+=1
      else
        fin_array[k]={}
        fin_array[k][:price]=v[:price]
        fin_array[k][:clearance]=v[:clearance]
        fin_array[k][:count]=1
      end
    end
  end
  fin_array
end

def apply_coupons(cart, coupons)
  fin_hash={}
  coupons.each do |coupon|
    #binding.pry
    if cart.keys.find(coupon[:item])

      if cart[coupon[:item]][:count]>=coupon[:num]
        binding.pry
        if cart.keys.find("#{coupon[:item]} W/COUPON")
          # binding.pry
          cart["#{coupon[:item]} W/COUPON"][:count]+=1
        else
          cart[coupon[:item]][:count]-=coupon[:num]
          cart["#{coupon[:item]} W/COUPON"]={}
          cart["#{coupon[:item]} W/COUPON"][:price]=coupon[:cost]
          cart["#{coupon[:item]} W/COUPON"][:clearance]=cart[coupon[:item]][:clearance]
          cart["#{coupon[:item]} W/COUPON"][:count]=1
        end
      end
    end
  end
  #binding.pry
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end

#consolidate_cart(cartao)
