require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'removes stray whitespace from string fields' do
    it 'name' do
      op = OrderProduct.new(prescription_number: ' PT1313199014  ', product: FactoryBot.build(:product))
      op.valid?
      expect(op.prescription_number).to eq 'PT1313199014'
    end
  end
end
