class AdminPolicy < ApplicationPolicy
  def show?
    !user ? false : user.Admin?
  end
end
