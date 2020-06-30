class BookHistoriesController<ApplicationController
  def destroy
    @hist=BookHistory.find(params[:id])
    IssuerMailer.book_issue_fail(@hist.issuer_id,@hist.book_id).deliver_now!
    @hist.destroy
    redirect_to current_user
  end
end
