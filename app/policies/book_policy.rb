class BookPolicy < ApplicationPolicy
  def index?
    user.type=="Manager" or user.type=="Issuer"
  end

  def show?
    user.type=="Issuer" or user.type=="Manager"
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    user.type=="Manager"
  end

  def create?
    user.type=="Manager"
  end

  def destroy?
    user.type=="Manager"
  end

  def change_status?
    user.type=="Manager"
  end

  def issue_book_request?
    user.type=="Issuer"
  end

  def issue_book?
    user.type=="Manager"
  end

  def return_book?
    user.type=="Issuer"
  end

  def search_book?
    user.type=="Issuer" or user.type=="Manager"
  end
end
