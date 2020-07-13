class ManagerPolicy < ApplicationPolicy

  def index?
    user && user.Admin?
  end

  def show?
    user && (user.Admin? || user.Manager?)
  end

  def new?
    create?
  end

  def create?
    user && user.Admin?
  end

  def edit?
    update?
  end

  def update?
    user && user.Admin?
  end

  def destroy?
    user && user.Admin?
  end

  def change_status?
    user && user.Admin?
  end
end
