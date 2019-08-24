# frozen_string_literal: true

# A line item on an order
class OrderProduct < ApplicationRecord
  auto_strip_attributes :prescription_number

  belongs_to :order
  belongs_to :product
  has_one :user, through: :order

  # This is an advanced AR query that joins with the products table and filters the results
  # down to just those orders with a linked restricted product. Far better than querying them
  # all and inefficiently iterating. In the Rails console, to see the SQL this generates
  # run OrderProduct.restricted.to_sql
  scope :restricted, -> { joins(:product).where(products: {category: :restricted}) }
  scope :rejected, -> { where(decision: 'reject') }
  scope :unsubmitted_for_decision, -> { where(decision_identifier: nil) }

  # Note: scopes can be chained, like OrderProduct.restricted.rejected...

  attr_accessor :current_user

  delegate :otc?, :prescription?, :restricted?, :name, to: :product

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

  validates :decision_identifier, length: { is: 36 }

  def veterinarian_alert?
    restricted? && !(user || current_user)&.veterinarian?
  end

  def accept?
    if !restricted?
      true
    elsif decision_identifier.present?
      false
    else
      decision == 'accept'
    end
  end

  def submit_for_decision_by_state_api
    return unless restricted?

    approval = RequestStateApproval.new(
      veterinarian_number: user.vet_registration_number,
      order_id: id,
      product_id: product.id,
      product_name: product.name
    )
    approval.run
    update_decision_result(approval.result)
  end

  private

  def update_decision_result(result)
    update(
      decision: result.decision,
      decision_identifier: result.decision_identifier,
      decided_at: Time.parse(result.decided_at)
    )
  end

  def validate_veterinarian_if_restricted
    return unless veterinarian_alert?

    errors.add(
      :product,
      'Restricted product may only be ordered by a registered Veterinarian. Please remove from order.'
    )
  end
end
