# frozen_string_literal: true

# This is the controller for the singleton resource cart in the routes file.
# Rails requires this to be plural by naming convention.
class CartsController < ApplicationController
  # The cart is instantiated in a before_action in application_controller
  # so that it is avaliable on all pages. However, each action that
  # modifies the cart needs to call the save_cart function to persist
  # the cart's contents back to a cookie as JSON

  before_action :load_product_id

  def add
    if @product_id
      @cart.add(product_id: @product_id)
      save_cart
      redirect_to(product_path(@product_id), only_path: true)
    else
      redirect_to(products_path, only_path: true)
    end
  end

  def remove
    if @product_id
      @cart.remove(product_id: @product_id)
      save_cart
      redirect_to(product_path(@product_id), only_path: true)
    else
      redirect_to(products_path, only_path: true)
    end
  end

  private

  # This method searches the database for a product with the specified product
  # When the product cannot be found, it returns nil because of the &. operator.
  def load_product_id
    @product_id = params[:product_id].to_i
    @product_id = nil unless Product.where(id: @product_id).any?
  end
end
