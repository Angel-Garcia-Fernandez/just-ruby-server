module OpenLibraryService
  class << self
    def get_book_data(isbn)
      uri = URI("https://openlibrary.org/api/books?bibkeys=ISBN:#{isbn}&format=json&jscmd=data")
      res = Net::HTTP.get_response(uri)
      raise new Error('Book not found') unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body)["ISBN:#{isbn}"]
    end
  end
end
