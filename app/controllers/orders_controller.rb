class OrdersController < ApplicationController
  def new
    @order = Order.build(user: current_user, cart: @cart)
    authorize @order
  end

  def order_params
    params.require(:order).permit(
      :name,
      :email,
      :phone,
      :address1,
      :address2,
      :city,
      :state,
      :zip
    )
  end
end