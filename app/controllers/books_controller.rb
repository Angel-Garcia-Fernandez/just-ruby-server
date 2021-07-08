class BooksController < BaseController
  def index
    @books = Book.all
    render(:index)
  end

  def show
    @book = Book.find(@params[:isbn])
    @book ? render(:show) : redirect_to('/books')
  end

  def new
    @book = Book.new
    render(:new)
  end

  def create
    @book = Book.new(@params)
    if @book.save
      redirect_to("/books/#{@book.isbn}")
    else
      render(:new)
    end
  end

  def edit
    @book = Book.find(@params[:isbn])
    @book ? render(:edit) : redirect_to('/books')
  end

  def update
    @book = Book.find(@params[:isbn])
    @book.assign(@params)
    @book.save ? redirect_to("/books/#{@book.isbn}") : render(:edit)
  end

  def destroy
    @book = Book.find(@params[:isbn])
    @book.destroy
    redirect_to('/books')
  end
end