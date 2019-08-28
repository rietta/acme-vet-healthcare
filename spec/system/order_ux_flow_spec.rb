require 'rails_helper'

# This test exercises the shopping cart as through a web browser.
RSpec.describe 'Order Placing', type: :system do

  def setup_product_in_cart(category:)
    @product = FactoryBot.create(:product, published: true, category: category)

    visit product_path(@product.id)
    click_on 'Add to Cart'
  end

  context 'Without Any Items in the Cart' do
    it 'Says cart is empty' do
      visit '/orders/new'
      expect(page).to have_text 'Your cart is empty'
    end
  end

  context 'Ordering OTC Product' do 
    it 'single item in cart is shown on order page' do
      setup_product_in_cart(category: 'otc')
      click_on 'Start Order'
      expect(page).to have_text @product.name
      expect(page).to have_link(
        @product.id,
        href: product_path(@product.id)
      )
    end
  end
  context 'Prescription product'
  context 'Restricted product'
end