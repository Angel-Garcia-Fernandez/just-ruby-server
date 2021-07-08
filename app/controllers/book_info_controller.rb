require_relative '../../resources/open_library_service'

class BookInfoController < BaseController

  def find_book
    isbn = @params[:isbn]
    redirect_to "/books/#{isbn}" unless isbn

    new_info = OpenLibraryService.get_book_data(isbn)
    if new_info
      Book.find(isbn).assign(new_info)
      redirect_to "/books/#{isbn}"
    end
  rescue StandardError => e
    @error = e.message
    redirect_to '/error'
  end
end
