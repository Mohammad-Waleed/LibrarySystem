class LibraryPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    update?
  end

  def update?
    user.type=="Admin"
  end
end
