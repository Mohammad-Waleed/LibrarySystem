class IssuersController < ApplicationController
 before_action :check_authorization
 before_action :set_issuer, only: [:edit, :update, :destroy, :show, :change_status, :approve]

  def index
    @issuers = Issuer.approved.where(library_id: current_user.library_id).order('created_at ASC')
  end

  def show
    if current_user.Admin?
      @book_history = BookHistory.where(issuer_id: @issuer_id, end_date: [nil, false])
    end
    @issued_books = BookHistory.where(issuer_id: @issuer.id, end_date: nil).where.not(start_date: nil)
    @fine = Library.find_by(id: @issuer.library_id).fine
    @books = Book.where(library_id: @issuer.library_id)
  end

  def update
    if @issuer.update(parameters)
      redirect_to issuers_path
    else
      render 'edit'
    end
  end

  def destroy
    if @issuer.destroy
      redirect_to issuers_path
    else
      redirect_to current_user
    end
  end

  def change_status
    @issuer.active? ? @issuer.inactive! : @issuer.active!
    redirect_to issuers_path
  end

  def approve
    if @issuer.unapproved?
      @issuer.approved!
    end
    redirect_to root_path
  end

  private

    def set_issuer
      @issuer = Issuer.find_by(id: params[:id])
    end

    def check_authorization
      authorize Issuer
    end

    def parameters
      params.require(:issuer).permit(:email, :password, :image, :fname, :lname, :balance, :status)
    end
end
