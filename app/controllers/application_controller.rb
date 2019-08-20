class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :load_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def load_cart
    @cart = Cart.new(json: session['cart'])
  end

  def save_cart
    session['cart'] = @cart.to_json
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:vet_registration_number])
  end
end
