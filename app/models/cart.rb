# frozen_string_literal: true

##
# This Plain Ruby Object handles the serialization of the shopping cart object.
# As the user adds and removes products, the cart_controller will update this object.
class Cart

  def initialize(json: nil)
    # Products will be stored as a hash, where the product id will be the
    # key and the quantity in the cart will be the value.
    @cart_contents = if json.blank?
                       {}
                     else
                       JSON.parse(json)
                     end
  end

  def add(product_id:)
    # Initialize the count to zero if the product is not already in the cart
    @cart_contents[product_id.to_s] ||= 0

    # Increase the quantity of the product in the cart
    @cart_contents[product_id.to_s] += 1
  end

  def remove(product_id:)
    @cart_contents.delete(product_id.to_s)
  end

  def contains?(product_id:)
    @cart_contents.include?(product_id.to_s)
  end

  def to_json(opts = nil)
    @cart_contents.to_json(opts)
  end


end
