class OrderPolicy < ApplicationPolicy
  def new?
    true
  end

  def create?
    true
  end
  
  def show?
    record.user == user
  end
end