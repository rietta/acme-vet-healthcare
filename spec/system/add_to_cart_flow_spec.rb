require 'rails_helper'

# This test exercises the shopping cart as through a web browser.
RSpec.describe 'Shopping Cart User Experience', type: :system do
  it 'allows items to be added and removed from the cart from the product page' do
    product = FactoryBot.create(:product, published: true)

    visit product_path(product.id)
    click_on 'Add to Cart'
    expect(page).to have_link('Remove from Cart', href: remove_cart_path(product_id: product.id))

    # Next, remove the item from the cart
    click_on 'Remove from Cart'
    expect(page).to have_link('Add to Cart', href: add_cart_path(product_id: product.id))
  end

end