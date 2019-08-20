require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a blank vet registration number' do
    user = FactoryBot.build(:user, vet_registration_number: nil)
    expect(user).to be_valid
  end

  it 'is invalid with an invalid vet number' do
    user = FactoryBot.build(:user, vet_registration_number: 'TR220092840')
    expect(user).to be_invalid
    expect(user.errors[:vet_registration_number]).to include(
      'must be a valid state Doctor identifier'
    )
  end

  it 'is valid with an valid vet number' do
    user = FactoryBot.build(:user, vet_registration_number: 'VR0051')
    expect(user).to be_valid
  end

  it 'when a user has a vet registration, that user is a veternarian' do
    user = FactoryBot.build(:user, vet_registration_number: 'VR0051')
    expect(user).to be_veterinarian
  end
end
