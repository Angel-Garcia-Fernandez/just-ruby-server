class BaseView
  def initialize(params = {})
    @params = params
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