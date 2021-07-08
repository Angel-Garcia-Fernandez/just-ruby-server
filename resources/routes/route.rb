module Route
  def match(request_line)
    path_target, in_line_params_ = request_line.split('?')
    @path_regex === path_target
  end

  def extract_params(request_line)
    path_target, in_line_params = request_line.split('?')
    params = (in_line_params || '').split('&').map { |pair| pair.split('=') }.to_h || {}

    param_values = @path_regex.match(path_target).captures
    params.merge(Hash[@param_names.zip(param_values)])
  end

  def resolve(request_line, data = {}); end

  private

  def path_to_regex(path)
    path = path.gsub(/:[\w_]+/, '(\d+)') # adding params
    path = path.gsub(/\*/, '.*') # adding globs
    Regexp.new "^#{path}$"
  end

end