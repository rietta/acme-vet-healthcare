require 'rails_helper'

RSpec.describe 'Home Page Marketing Content', type: :system do
  it 'homepage has the title expected by marketing' do
    visit '/'
    expect(page).to have_text 'Welcome to ACME&reg; Barn Yard Veterinary Healthcare'
  end
end