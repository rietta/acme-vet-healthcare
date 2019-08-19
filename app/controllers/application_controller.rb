class ApplicationController < ActionController::Base
  before_action :load_cart

  def load_cart
    @cart = Cart.new(json: cookies['cart'])
  end

  def save_cart
    cookies['cart'] = @cart.to_json
  end
end
