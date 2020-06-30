class IssuerPolicy < ApplicationPolicy
  def index?
    user.type=="Admin"
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
    user.type=="Admin"
  end

  def create?
    user.type=="Admin"
  end

  def destroy?
    user.type=="Admin"
  end

  def change_status?
    user.type=="Admin"
  end

  def approve?
    user.type=="Admin"
  end
end
