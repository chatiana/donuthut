class CartController < ApplicationController
  before_action :authenticate_user!
######### start of add to cart logic ######### 
  
  def add
    # we need the id of the product to be added
    # lets get it now
    
    id = params[:id]
    # if the cart exists already use it if not make a new one
    if session[:cart] then
      
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end
    
    # If the product is in the cart then increase the existing quantity by 1
    
    if cart[id] then
    
    cart[id] = cart[id] + 1 # this is the actual increase quantity part
     else
    
    cart[id] = 1
    
    end
    
    redirect_to :action => :index
    
  end 
  
############### Start of index logic ####################
  
  def index
    # this method will pass the content of the cart to the page view
    
    if session[:cart] then
      @cart = session[:cart] # if session exists the pass cart contents to the cart view
     else 
       @cart = {} # if the cart isnt a session the say the cart contents is empty
       
    end  
    
  end


###############Method to Clear the cart ####################
  def clearCart
    #sets session variable to nil and bring back to index
    session[:cart] = nil
    redirect_to :action => :index
  end



############## Delete Item method ##############
  def remove
    id = params[:id]
    cart = session[:cart]
    cart.delete id
    
    redirect_to :root
  end



#########Decrease the quantity ###############
  def decrease
    
    id = params[:id]
    cart = session[:cart]
    if cart[id] == 1 then
       cart.delete id
     else
     cart[id] = cart[id] - 1
    end
     #Taking us to cart index[view] page
    redirect_to :action => :index
  end
  
######## Create Order method ########  
  def createOrder
 # Step 1: Get the current user
 @user = User.find(current_user.id)

 # Step 2: Create a new order and associate it with the current user
 @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
 @order.save

 # Step 3: For each item in the cart, create a new item on the order!!
 @cart = session[:cart] || {} # Get the content of the Cart
 @cart.each do | id, quantity |
 item = Item.find_by_id(id)
 @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price=> item.price)
 @orderitem.save
 end
 #redirect_to '/orderConfirmed/'#
 @orderitems = Orderitem.where(order_id: Order.last)
  end

end