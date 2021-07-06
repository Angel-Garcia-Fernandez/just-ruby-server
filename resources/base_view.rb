class BaseView
  def respond(status_code, message_body)
    <<~MSG
      HTTP/1.1 #{status_code}
      Content-Type: text/html

      #{message_body}
    MSG
  end
end