class OrdersController < ApplicationController
  def new
    @order = Order.new(user: current_user)
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