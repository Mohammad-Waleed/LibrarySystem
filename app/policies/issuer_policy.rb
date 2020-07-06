class IssuerPolicy < ApplicationPolicy
  def index?
    !user ? false : user.Admin?
  end

  def show?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    !user ? false : user.Admin?
  end

  def create?
    !user ? false : user.Admin?
  end

  def destroy?
    !user ? false : user.Admin?
  end

  def change_status?
    !user ? false : user.Admin?
  end

  def approve?
    !user ? false : user.Admin?
  end
end
