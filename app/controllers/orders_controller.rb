# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.build(user: current_user, cart: @cart)
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    authorize @order
    if @order.save && @order.process_restrictions
      @cart.clear
      render :show
    else
      render :new
    end
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
      :zip,
      order_products_attributes: %i[id product_id prescription_number _destroy]
    )
  end
end
