require_relative 'route'

class RedirectionRoute
  include Route

  def initialize(method, path, redirect_to)
    @method = method
    @path = path
    @redirect_to = redirect_to
    @path_regex = path_to_regex(path)
    @param_names = path.scan(/:([\w_]+)/).flatten
  end
end