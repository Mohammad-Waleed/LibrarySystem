class BookHistoriesController<ApplicationController
  before_action :set_book_history, only: [ :destroy]

  def destroy
    IssuerMailer.book_issue_fail(@hist.issuer_id,@hist.book_id).deliver_now!
    @book_history.destroy ? redirect_to current_user : flash[:alert] = 'Could not delete the book !'
    render current_user
  end

  private

    def set_book_history
      @book_history = BookHistory.find_by(id: params[:id])
    end
end
