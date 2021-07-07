module Route
  def match(request_line)
    path_target, in_line_params_ = request_line.split('?')
    @path_regex === path_target
  end

  def extract_params(path_target)
    param_values = @path_regex.match(path_target).captures
    Hash[@param_names.zip(param_values)]
  end

  private

  def path_to_regex(path)
    path = path.gsub(/:[\w_]+/, '(\d+)') # adding params
    path = path.gsub(/\*/, '.*') # adding globs
    Regexp.new "^#{path}$"
  end

end