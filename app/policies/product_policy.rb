# frozen_string_literal: true

# This policy covers which users can access any given product or
# - in the case of site admins - manage.
class ProductPolicy < ApplicationPolicy
  # An inner class called Scope is defined by the generator in
  # ApplicationPolicy, but it is really inefficient to query the
  # database for all products to the individually call index? on
  # each of them. Therefore, here we redefine the Scope inner class
  # to run a different query for a user logged in as admin vs a
  # member of the public or veterianarian.
  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      else
        scope.published
      end
    end
  end

  def index?
    record.published? || user&.admin?
  end

  def show?
    record.published? || user&.admin?
  end

  def create?
    user&.admin?
  end

  def update?
    user&.admin?
  end

  def destroy?
    user&.admin?
  end
end
