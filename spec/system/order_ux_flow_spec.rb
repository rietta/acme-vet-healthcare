require 'rails_helper'

# This test exercises the shopping cart as through a web browser.
RSpec.describe 'Order Placing', type: :system do

  let(:order_template) { FactoryBot.build(:order )}
  let(:user_password) { SecureRandom.hex }
  let(:user) { FactoryBot.create(:user, role: :visitor, password: user_password) }
  let(:vet_user) { FactoryBot.create(:user, role: :visitor, vet_registration_number: 'VR090902414', password: user_password) }


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

  def login_as_vet
    user.save
    click_on 'Sign in'
    fill_in 'Email', with: vet_user.email
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
      expect(page).to have_text 'Order Submitted'
      expect(page).to have_text 'It has been submitted for processing'
    end


  end

  context 'Prescription product' do
    before(:each) do
      setup_product_in_cart(category: 'prescription')
      login_as_user
      click_on 'Start Order'
      fill_in_customer_details
    end

    it 'fails without a prescription number' do
      click_on 'Create Order'
      expect(page).to_not have_text 'Order Submitted'
    end

    it 'succedes with a prescription number' do
      fill_in 'Prescription number', with: 'PR00098'
      click_on 'Create Order'
      expect(page).to have_text 'Order Submitted'
      expect(page).to have_text 'It has been submitted for processing'
    end
  end

  context 'Restricted product' do
    context 'as a non-veternarian' do
      before(:each) do
        setup_product_in_cart(category: 'restricted')
        login_as_user
        click_on 'Start Order'
        fill_in_customer_details
      end

      it 'shows a warning about restricted item' do
        expect(page).to have_text 'This product is restricted by law'
      end

      it 'prevents order entry with a restricted item that must be removed' do
        click_on 'Create Order'
        expect(page).to have_text 'Restricted product may only be ordered by a registered Veterinarian'
      end
    end

    context 'as a veternarian' do
      before(:each) do
        setup_product_in_cart(category: 'restricted')
        login_as_vet
        click_on 'Start Order'
        fill_in_customer_details
      end

      it 'does not showsa warning about restricted item' do
        expect(page).to_not have_text 'This product is restricted by law'
      end

      it 'proceedes to order submitted' do
         click_on 'Create Order'
         expect(page).to have_text 'Order Submitted'
         expect(page).to have_text 'It has been submitted for processing'
      end
    end
  end
end