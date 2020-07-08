class BookHistoriesController < ApplicationController
  before_action :set_book_history, only: [:destroy]

  def destroy
    if @book_history.destroy
      redirect_to current_user
    else
      flash[:alert] = 'Could not delete the book!'
    end
    render current_user
  end

  private

    def set_book_history
      @book_history = BookHistory.find_by(id: params[:id])
    end
end
