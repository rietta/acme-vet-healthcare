require 'rails_helper'

RSpec.describe Product, type: :model do

  it 'is invalid when name is blank' do
    product = Product.new(name: '')
    expect(product).to be_invalid
    expect(product.errors[:name]).to eq ["can't be blank"]
  end

  it 'is invalid when name is longer than 255 characters' do
    product = Product.new(name: 'AA' * 200)
    expect(product).to be_invalid
    expect(product.errors[:name]).to eq ["is too long (maximum is 255 characters)"]
  end

  it 'is invalid when category is nil/NULL' do
    product = Product.new(name: 'test')
    expect(product).to be_invalid
    expect(product.errors[:category]).to eq ["can't be blank"]
  end

  it 'can be saved to the database even when description is over 256 characters' do
    product = Product.new(
      name: 'test',
      category: :otc,
      description: 'AA' * 512
    )
    expect do
      product.save!
    end.to_not raise_error
  end

  describe 'is invalid when category is not one of :otc, :presciption, or :restricted' do
    it 'is invalid with bogus category' do
      expect do
        Product.new(
          name: 'test',
          category: 'Bogus Category Name'
        )
      end.to raise_error ArgumentError
    end

    it 'is valid with otc' do
      expect do
        Product.new(name: 'test', category: :otc)
      end.to_not raise_error
    end

    it 'is valid with prescription' do
      expect do
        Product.new(name: 'test', category: :prescription)
      end.to_not raise_error
    end


    it 'is valid with restricted' do
      expect do
        Product.new(name: 'test', category: :restricted)
      end.to_not raise_error
    end
  end


end
