# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RequestStateApproval, type: :model do
  let(:subject) do
    RequestStateApproval.new(
      veterinarian_number: 'VR0912',
      order_id: 'ACME234241',
      product_id: '1337',
      product_name: 'Carfentanil'
    )
  end

  it 'runs without crashing' do
    expect do
      subject.run
    end.to_not raise_error
  end

  it '.success? returns false before running' do
    expect(subject.success?).to eq false
  end

  it '.retry? returns true before running' do
    expect(subject.retry?).to eq true
  end
end
