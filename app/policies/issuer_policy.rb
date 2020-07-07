class IssuerPolicy < ApplicationPolicy
  def index?
    user && user.Admin?
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
    user && user.Admin?
  end

  def create?
    user && user.Admin?
  end

  def destroy?
    user && user.Admin?
  end

  def change_status?
    user && user.Admin?
  end

  def approve?
    user && user.Admin?
  end
end
