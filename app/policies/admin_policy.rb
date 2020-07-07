class AdminPolicy < ApplicationPolicy
  def show?
    user && user.Admin?
  end
end
