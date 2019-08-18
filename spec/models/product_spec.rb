require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'is invalid when name is blank' do
    product = Product.new(name: '')
    expect(product).to be_invalid
    expect(product.errors).to include ['name cannot be blank']
  end
  it 'is invalid when name is longer than 255 characters'
  it 'database returns an error when forced to save a name longer than 255 characters'
  it 'is invalid when category is nil/NULL'
  it 'is valid when description is over 256 characters'
end
