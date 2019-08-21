# frozen_string_literal: true

# A line item on an order
class OrderProduct < ApplicationRecord
  auto_strip_attributes :prescription_number

  belongs_to :order
  belongs_to :product
  has_one :user, through: :order

  attr_accessor :current_user

  delegate :otc?, :prescription?, :restricted?, to: :product

  # Conditional Validations in Rails

  # This validate statement will cause the specified function
  # (which is under the private block) to be called
  validate :validate_veterinarian_if_restricted

  # This validates statement is made conditional by the if: on the line.
  # Also notice that I kept it from being longer than 80 characters on a
  # single line by surrounding with parathesis and placing each element on
  # a new line. In Ruby, validates is a class method!
  validates(
    :prescription_number,
    presence: true,
    length: { minimum: 6 },
    if: :prescription?
  )

  def veterinarian_alert?
    restricted? && !(user || current_user)&.veterinarian?
  end

  private

  def validate_veterinarian_if_restricted
    return unless veterinarian_alert?

    errors.add(
      :product,
      'Restricted product may only be ordered by a registered Veterinarian'
    )
  end
end
