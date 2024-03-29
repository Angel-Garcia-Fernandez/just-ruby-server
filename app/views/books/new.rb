class New < BaseView
  def render
    respond(200, html)
  end

  def html
    <<~BODY
    <form action='/books' method='post' enctype='application/x-xxx-form-urlencoded'>
      <p><label>Title <input type='text' name='title'></label></p>
      <p><label>Date bought <input type='date' name='bought_at'></label></p>
      <p><label>ISBN <input type='number' name='isbn'></label></p>
      <p><button>Add new entry</button></p>
    </form>
    BODY
  end
end
