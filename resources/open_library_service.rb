require 'net/http'
require 'json'

module OpenLibraryService
  class << self
    def get_book_data(isbn)
      uri = URI("https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
      res = Net::HTTP.get_response(uri)
      raise new Error('Book not found') unless res.is_a?(Net::HTTPSuccess)

      book_data = JSON.parse(res.body)["ISBN:#{isbn}"]
      { title: book_data['title'],
        pages: book_data['number_of_pages'],
        published: book_data['publish_date'],
        image: book_data.dig('cover', 'small'),
        author: book_data.dig('authors', 0, 'name') }
    end
  end
end
