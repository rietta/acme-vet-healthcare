require 'rails_helper'

RSpec.describe 'Home Page Marketing Content', type: :system do
  it 'homepage has the title expected by marketing' do
    visit '/'
    expect(page).to have_text 'Welcome to ACME® Barn Yard Veterinary Healthcare'
  end

  it 'has a link to the products page that mentions a count of products' do
    # I'm using Factory Bot here to create lists of random products and overridding
    # a value so that I have an exact count known to me at this point
    FactoryBot.create_list(:product, 5, published: true)
    FactoryBot.create_list(:product, 3, published: false)

    visit '/'
    expect(page).to have_link('Choose from 5 Products', href: products_path)
  end
end