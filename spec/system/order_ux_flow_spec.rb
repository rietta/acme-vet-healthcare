require 'rails_helper'

# This test exercises the shopping cart as through a web browser.
RSpec.describe 'Order Placing', type: :system do

  let(:order_template) { FactoryBot.build(:order )}
  let(:user_password) { SecureRandom.hex }
  let(:user) { FactoryBot.create(:user, role: :visitor, password: user_password) }

  def setup_product_in_cart(category:)
    @product = FactoryBot.create(:product, published: true, category: category)

    visit product_path(@product.id)
    click_on 'Add to Cart'
  end

  def login_as_user
    user.save
    click_on 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user_password
    click_on 'Log in'
  end



  def fill_in_customer_details
    fill_in 'Name', with: order_template.name
    fill_in 'Email', with: order_template.email
    fill_in 'Phone', with: order_template.phone
    fill_in 'Address1', with: order_template.address1
    fill_in 'Address2', with: order_template.address2
    fill_in 'City', with: order_template.city
    fill_in 'State', with: order_template.state
    fill_in 'Zip', with: order_template.zip
  end

  context 'Without Any Items in the Cart' do
    it 'Says cart is empty' do
      visit '/orders/new'
      expect(page).to have_text 'Your cart is empty'
    end
  end

  context 'Ordering OTC Product' do 
    

    before(:each) do
      setup_product_in_cart(category: 'otc')
      login_as_user
      click_on 'Start Order'
    end

    it 'single item in cart is shown on order page' do
      expect(page).to have_text @product.name
      expect(page).to have_link(
        @product.id,
        href: product_path(@product.id)
      )
    end

    it 'succeeds with customer details' do
      fill_in_customer_details
      click_on 'Create Order'
    end


  end
  context 'Prescription product'
  context 'Restricted product'
end