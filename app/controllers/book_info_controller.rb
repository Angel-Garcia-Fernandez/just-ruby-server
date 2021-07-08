require_relative '../../resources/open_library_service'

class BookInfoController < BaseController

  def find_book
    isbn = @params[:isbn]
    redirect_to "/books/#{isbn}" unless isbn

    book_data = OpenLibraryService.get_book_data(isbn)
    if book_data
      book = Book.find(isbn).assign(book_data)
      puts book_data

      book.save
      redirect_to "/books/#{isbn}"
    end
  rescue StandardError => e
    puts e.message
    redirect_to '/error'
  end
end
