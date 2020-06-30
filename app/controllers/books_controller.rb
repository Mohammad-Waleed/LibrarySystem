class BooksController<ApplicationController
  before_action :book_params,only:[:create]
  before_action :find_book,only:[:change_status,:show,:edit,:update,:destroy]

  def index
    @books = authorize Book.where(library_id: current_user.library_id)
  end

  def new
    @book=Book.new
  end

  def create
    fields=book_params
    fields[:library_id]=current_user.library_id
    @book= authorize Book.new(fields)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def show
    authorize @book
  end

  def edit
    authorize @book
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to current_user
  end

  def change_status
    authorize @book
    if  @book.available?
      @book.update(status:'unavailable')
    else
      @book.update(status:'available')
    end
    redirect_to books_path
  end

  def issue_book_request
    @book=authorize Book.find(params[:id])
    if @book.unavailable?
      flash[:alert]="Sorry the book is not available :("
      redirect_to current_user
    elsif BookHistory.where(book_id:params[:id],issuer_id:current_user.id,end_date:nil).count>0
      flash[:alert]="You have already requested or issued this book!"
      redirect_to current_user
    else
      @history=BookHistory.create(book_id:@book.id,issuer_id:current_user.id)
      if @history.save
        current_user.book_histories << @history
        flash[:notice] = "You have successfully requested for a book!."
        redirect_to current_user
      else
        render 'show'
      end
    end
  end

  def issue_book
    authorize Book
    @history=BookHistory.find(params[:id])
    if @history.update(start_date:Time.now.strftime("%d/%m/%Y").to_s)
      @issuer=Issuer.find(@history.issuer_id)
      @issuer.book_histories << @history
      flash[:notice] = "You have successfully issued book!."
      IssuerMailer.book_issue_success(@history.issuer_id,@history.book_id).deliver_now!
      redirect_to current_user
    else
      render 'show'
    end
  end

  def search_book
    @books=authorize Book.where("LOWER(#{params[:search_key]}) LIKE LOWER(?) and library_id = ?", "%#{params[:book][:title]}%",current_user.library_id)
  end

  def return_book
    @book=authorize Book.find(params[:id])
    @history=BookHistory.where(book_id:params[:id],issuer_id:current_user.id)
    if @history.update(end_date:Time.now.strftime("%m/%d/%Y").to_s)
      flash[:notice] = "You have successfully returned book!."
      redirect_to current_user
    else
      render 'show'
    end
  end

private

  def find_book
    @book=Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title,:isbn,:status,:author,:year,:genre,:no_of_copies,images:[])
  end
end
