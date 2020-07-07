 class BooksController<ApplicationController
  before_action :check_authorization
  before_action :book_params, only: [:create]
  before_action :set_book, only: [:change_status, :show, :edit, :update, :destroy, :issue_book_request, :return_book]
  before_action :set_book_history, only: [:issue_book]

  def index
    @books = Book.where(library_id: current_user.library_id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    if !@book.destroy
      flash[:alert] = 'Could not delete the book!'
    end
    redirect_to current_user
  end

  def change_status
    @book.available? ? @book.unavailable! : @book.available!
    redirect_to books_path
  end

  def issue_book_request
    if @book.unavailable?
      flash[:alert] = 'Sorry the book is not available :('
    elsif already_requested?(@book)
      flash[:alert] = 'You have already requested or issued this book!'
    else
      insert_book_request(@book)
    end

    redirect_to current_user
  end

  def issue_book
    if @book_history.update(start_date: Time.now.strftime('%d/%m/%Y'))
      @issuer = Issuer.find_by(id: @book_history.issuer_id)
      @issuer.book_histories << @book_history
      flash[:notice] = 'You have successfully issued book!'
      IssuerMailer.book_issue_success(@book_history.issuer_id,@book_history.book_id).deliver_now!
      redirect_to current_user
    else
      render 'show'
    end
  end

  def search_book
    @books = Book.where("LOWER( #{params[:search_key]}) LIKE LOWER(?) and library_id = ?", "%#{params[:book][:title]}%",current_user.library_id)
  end

  def return_book
    @book_history = @book.book_histories.where(issuer_id: current_user.id)

    if @book_history.update(end_date: Time.now.strftime('%m/%d/%Y'))
      flash[:notice] = 'You have successfully returned book!'
      redirect_to current_user
    else
      render 'show'
    end
  end

  private

    def set_book
      @book = Book.find_by(id: params[:id])
    end

    def set_book_history
      @book_history = BookHistory.find_by(id: params[:id])
    end

    def already_requested?(book)
      book.book_histories.where(issuer_id: current_user.id, end_date: nil).count > 0
    end

    def insert_book_request(book)
      book_history = book.book_histories.create(issuer_id: current_user.id)

      if book_history.save
        current_user.book_histories << book_history
        flash[:notice] = 'You have successfully requested for a book!'
      else
        render 'show'
      end
    end

    def book_params
      params.require(:book).permit(:title, :isbn, :status, :author, :year, :genre, :no_of_copies, images: []).tap do |hash|
        hash[:library_id] = current_user.library_id
      end
    end

    def search_params
      params.require(:book).permit(:title)
    end

    def check_authorization
      authorize Book
    end
end
