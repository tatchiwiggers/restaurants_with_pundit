class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    owner_admin?
  end

  def destroy?
    owner_admin?
  end

  private

  def owner_admin?
    user == record.user || user.admin
  end
end
