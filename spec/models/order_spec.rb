require 'rails_helper'

RSpec.describe Order, type: :model do

  describe 'removes stray whitespace from string fields' do
    it 'name' do
      order = FactoryBot.build(:order, name: ' test   ')
      order.valid?
      expect(order.name).to eq 'test'
    end

    it 'phone' do
      order = FactoryBot.build(:order, phone: '770-555-1212 ')
      order.valid?
      expect(order.phone).to eq '770-555-1212'
    end
  end
  
end
