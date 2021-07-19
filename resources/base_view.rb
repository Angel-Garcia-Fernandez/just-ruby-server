class BaseView

  #overwritable method used by controllers for the views to use
  def render
    raise StandardError.new('there\'s no view or view doesn\'t implement render method')
  end

  def respond(status_code, message_body)
    <<~MSG
      HTTP/1.1 #{status_code}
      Content-Type: text/html

      #{message_body}
    MSG
  end

  def redirect_to(path)
    <<~MSG
      HTTP/1.1 302
      Content-Type: text/html
      Location: #{path}

    MSG
  end
end