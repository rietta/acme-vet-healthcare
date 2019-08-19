class ApplicationController < ActionController::Base
  before_action :load_cart

  def load_cart
    @cart = Cart.new(json: session['cart'])
  end

  def save_cart
    session['cart'] = @cart.to_json
  end
end
