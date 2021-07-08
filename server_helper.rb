def get_full_request(session)
  request = []
  while (line = session.gets) && (line.chomp.length > 0)
    request << line.chomp
  end
  request
end

def extract_data(request, session)
  headers = {}
  request.each do |line|
    if line.include?(': ')
      key, value = line.split(': ')
      headers[key] = value
    end
  end

  content_length = headers['Content-Length']&.to_i
  if content_length && headers['Content-Type'] == 'application/x-www-form-urlencoded'
    # extract body
    body = session.read(content_length)
    URI.decode_www_form(body).to_h
  end
end