class BookPolicy < ApplicationPolicy

  def index?
    user && (user.Manager? || user.Issuer?)
  end

  def show?
    user && (user.Manager? || user.Issuer?)
  end

  def new?
    create?
  end

  def create?
    user && user.Manager?
  end

  def destroy?
    user && user.Manager?
  end

  def edit?
    update?
  end

  def update?
    user && user.Manager?
  end

  def change_status?
    user && user.Manager?
  end

  def issue_book_request?
    user && user.Issuer?
  end

  def issue_book?
    user && user.Manager?
  end

  def return_book?
    user && user.Issuer?
  end

  def search_book?
    user && (user.Manager? || user.Issuer?)
  end
end
