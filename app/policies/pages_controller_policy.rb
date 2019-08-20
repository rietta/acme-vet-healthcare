# frozen_string_literal: true

class PagesControllerPolicy
  def initialize(_user, _ctrlr); end
  
  def home?
    true
  end
  
end
