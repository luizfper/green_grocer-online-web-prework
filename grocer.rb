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

    if cart.keys.include?(coupon[:item])
      #binding.pry
      if cart[coupon[:item]][:count]>=coupon[:num]
        cart[coupon[:item]][:count]-=coupon[:num]
        clearance=cart[coupon[:item]][:clearance]
        if cart[coupon[:item]][:count]<0
          cart.delete(coupon[:item])
        end
        if cart.keys.include?("#{coupon[:item]} W/COUPON")
          #binding.pry
          cart["#{coupon[:item]} W/COUPON"][:count]+=1
        else
          #binding.pry
          cart["#{coupon[:item]} W/COUPON"]={}
          cart["#{coupon[:item]} W/COUPON"][:price]=coupon[:cost]
          cart["#{coupon[:item]} W/COUPON"][:clearance]=clearance
          cart["#{coupon[:item]} W/COUPON"][:count]=1
        end
      end
    end
  end
  #binding.pry
  cart
end

def apply_clearance(cart)
  fin_hash=cart
  cart.each do |k,v|
    #binding.pry
    if v[:clearance]
      v[:price]=(v[:price]*0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  fin_cart=consolidate_cart(cart)
  fin_cart = apply_coupons(fin_cart, coupons)
  fin_cart = apply_clearance(fin_cart)
  total=0
  fin_cart.each {|k,v|total+=(v[:price]*v[:count])}
  total = total*0.9 if total>100
  total
end

#consolidate_cart(cartao)
