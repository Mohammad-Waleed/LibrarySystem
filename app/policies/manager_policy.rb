class ManagerPolicy < ApplicationPolicy
  def index?
    user.type=="Admin"
  end

  def show?
    user.type=="Admin" or user.type=="Manager"
  end

  def new?
    create?
  end

  def create?
    user.type=="Admin"
  end

  def edit?
    update?
  end

  def update?
    user.type=="Admin"
  end

  def destroy?
    user.type=="Admin"
  end

  def change_status?
    user.type=="Admin"
  end
end
