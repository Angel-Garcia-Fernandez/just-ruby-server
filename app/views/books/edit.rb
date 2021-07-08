class Edit < BaseView
  def render
    respond(200, html)
  end

  def html
    <<~BODY
    <form action='/books/#{@params[:isbn]}' method='post' enctype='application/x-xxx-form-urlencoded'>
      <input name='_method' type='hidden' value='put'>
      <p><label>Name <input type='text' name='name' value='#{@book.name}'></label></p>
      <p><label>Date bought <input type='date' name='bought_at' value='#{@book.bought_at}'></label></p>
      <p><label>ISBN <input type='number' name='isbn' value='#{@book.isbn}'></label></p>
      <p><button>Save</button></p>
    </form>
    BODY
  end
end