class LibraryPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    update?
  end

  def update?
    !user ? false : user.Admin?
  end
end
