class AdminPolicy < ApplicationPolicy
  def show?
    user.type=="Admin"
  end
end
