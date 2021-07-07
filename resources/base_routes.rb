class BaseRoutes
  METHODS = [
    GET = 'GET',
    POST = 'POST',
    PUT = 'PUT',
    DELETE = 'DELETE'
  ]

  # Inner class to manage routes
  class RoutesHash
    def initialize
      @hash = { GET => {}, POST => {}, PUT => {}, DELETE => {} }
    end

    def add(method, path, controller, action)
      path_regex = Regexp.new "^#{path.gsub(/:[\w_]+/, '(\d+)')}$"
      param_names = path.scan(/:([\w_]+)/).flatten
      @hash[method][path_regex] = [controller, action, path_regex, param_names]
    end

    def get(method, request_line)
      @hash[method].find { |path_regex, values_| path_regex === request_line }&.last
    end
  end

  # BaseRoutes methods
  def initialize
    @routes = RoutesHash.new
    define_routes
  end

  def resolve(method_token, request_line)
    path_target, in_line_params = request_line.split('?')

    #Find the correct route
    controller, action, path_regex, param_names = @routes.get(method_token, path_target)
    return unless controller && action

    #extract params
    param_values = path_regex.match(path_target).captures
    params = Hash[param_names.zip(param_values)]

    #execute controller
    require_relative "../app/controllers/#{controller}_controller"
    controller = self.class.const_get("#{controller.capitalize}Controller")
    controller.new(params).send(action)
  end

  private

  # Adding a get route
  def get(path, opts={})
    controller, action = opts[:to].split('#')
    @routes.add(GET, path, controller, action)
  end

  def define_routes; end
end
