class Edit < BaseView
  def render
    respond(200, html)
  end

  def html
    <<~BODY
    <h1>Book with ISBN #{@book.isbn} </h1>
    <form action='/books/#{@params[:isbn]}' method='post' enctype='application/x-xxx-form-urlencoded'>
      <input name='_method' type='hidden' value='put'>
      <input type='hidden' name='isbn' value='#{@book.isbn}'>
      <p><label>Title <input type='text' name='title' value='#{@book.title}'></label></p>
      <p><label>Date bought <input type='date' name='bought_at' value='#{@book.bought_at}'></label></p>
      <p><button>Save</button></p>
    </form>
    BODY
  end
end