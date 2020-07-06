class ManagerPolicy < ApplicationPolicy

  def index?
    !user ? false : user.Admin?
  end

  def show?
    !user ? false : user.Admin? || user.Manager?
  end

  def new?
    create?
  end

  def create?
    !user ? false : user.Admin?
  end

  def edit?
    update?
  end

  def update?
    !user ? false : user.Admin?
  end

  def destroy?
    !user ? false : user.Admin?
  end

  def change_status?
    !user ? false : user.Admin?
  end
end
