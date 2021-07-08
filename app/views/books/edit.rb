class Edit < BaseView
  def render
    respond(200, html)
  end

  def html
    <<~BODY
    <form action='/books/#{@params[:isbn]}' method='put' enctype='application/x-xxx-form-urlencoded'>
      <p><label>Name <input type='text' name='name' value='#{@book.name}'></label></p>
      <p><label>Date bought <input type='date' name='bought_at' value='#{@book.bought_at}'></label></p>
      <p><label>ISBN <input type='number' name='isbn' value='#{@book.isbn}'></label></p>
      <p><button>Save</button></p>
    </form>
    BODY
  end
end