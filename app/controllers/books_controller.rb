class BooksController < BaseController
  def index
    @books = Book.all
    render(:index)
  end

  def show
    @book = Book.find(@params[:isbn])
    render(:show)
  end

  def new
    @book = Book.new
    render(:new)
  end

  def create
    @book = Book.new(@params)
    if @book.save
      redirect_to("/books/#{@book[:isbn]}")
    else
      render(:new)
    end
  end

  def edit
    @book = Book.find(@params[:isbn])
    render(:edit)
  end

  def update
    @book = Book.assign(@params)
    if @book.save
      redirect_to("/books/#{@book[:isbn]}")
    else
      render(:edit)
    end
  end

  def destroy
    @book = Book.find(@params[:isbn])
    @book.destroy
    redirect_to('/books')
  end
end