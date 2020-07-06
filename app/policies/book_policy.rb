class BookPolicy < ApplicationPolicy

  def index?
    !user ? false : user.Manager? || user.Issuer?
  end

  def show?
    !user ? false : user.Manager? || user.Issuer?
  end

  def new?
    create?
  end

  def create?
    !user ? false : user.Manager?
  end

  def destroy?
    !user ? false : user.Manager?
  end

  def edit?
    update?
  end

  def update?
    !user ? false : user.Manager?
  end

  def change_status?
    !user ? false : user.Manager?
  end

  def issue_book_request?
    !user ? false : user.Issuer?
  end

  def issue_book?
    !user ? false : user.Manager?
  end

  def return_book?
    !user ? false : user.Issuer?
  end

  def search_book?
    isManager || user.Issuer?
  end
end
