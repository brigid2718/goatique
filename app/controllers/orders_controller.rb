class OrdersController < ApplicationController




  def index
    @order = @current_order
  end

  def show
    @order = @current_order
  end

  def checkout
  end

  def final_countdown
     #update @current_order with params from form
     @current_order.update(params.require(:order).permit(:first_name, :last_name, :mailing_address, :email, :card_number, :expiration_date))

     #change status to paid

     if @current_order.update(order_status: "Paid")
       #   iterate through order_items and update_stock based on #of items ordered(needs to be in model bc relates to DB)
       puts @current_order.order_items.first.product.quantity
       @current_order.order_items.each do |order_item|
         new_stock = order_item.product.quantity - order_item.product_quantity
         order_item.product.update(quantity: new_stock)
       end
       puts @current_order.order_items.first.product.quantity

       #   set current  session order id to nil
       #   redirect_to new confirmation page (maybe refactor to partial)
     else
       raise "Boo not paid"
       # else
       #   throw error
       #   (refactor) redirect to cart/checkout page
       #
     end

  end

  def update_all
    #method that updates all of the order quantities
  end

  def order_params
    params.require(:mango).permit(:order_item) #can i access the attributes of the other models that Orders is associated with, such as price, etc?
  end
end
