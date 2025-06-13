class ProductPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    user.present? && user.seller?
  end

  def update?
    user.present? && (user.admin? || record.seller == user)
  end

  def destroy?
    user.present? && (user.admin? || record.seller == user)
  end

  class Scope < Scope
    def resolve
      if user&.admin?
        scope.all
      elsif user&.seller?
        scope.where(seller: user)
      else
        scope.none
      end
    end
  end
end
