# frozen_string_literal: true

class CartsControllerPolicy
  def initialize(_user, _ctrlr); end
  
  def add?
    true
  end

  def remove?
    true
  end
end
