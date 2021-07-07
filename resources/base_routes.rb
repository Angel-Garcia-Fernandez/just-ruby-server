require_relative 'routes/controller_route'
require_relative 'routes/redirection_route'

class BaseRoutes
  METHODS = [
    GET = 'GET',
    POST = 'POST',
    PUT = 'PUT',
    DELETE = 'DELETE'
  ]

  # Inner class to manage every route
  class RoutesHash
    # RoutesHash methods
    def initialize
      @hash = { GET => [], POST => [], PUT => [], DELETE => [] }
    end

    def add_controller_route(method, path, controller, action)
      route = ControllerRoute.new(method, path, controller, action)
      @hash[method] << route
    end

    def add_redirection_route(method, path, redirect_to)
      route = RedirectionRoute.new(method, path, redirect_to)
      @hash[method] << route
    end

    def get(method, request_line)
      @hash[method].find { |route| route.match(request_line) }
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
    route = @routes.get(method_token, path_target)
    return unless route

    #execute controller
    route.resolve(path_target)
  end

  private

  # Adding any type route
  def match(path, method, opts={})
    add_route(method, path, opts)
  end

  # Adding a get route
  def get(path, opts={})
    add_route(GET, path, opts)
  end

  # Adding a get route
  def post(path, opts={})
    add_route(POST, path, opts)
  end

  # Adding a get route
  def put(path, opts={})
    add_route(PUT, path, opts)
  end

  # Adding a delete route
  def delete(path, opts={})
    add_route(DELETE, path, opts)
  end


  # Method overwritten by inherited classes to define its routes
  def define_routes; end


  def add_route(method, path, opts)
    raise StandardError('wrong route: needs to: or redirect_to: options') unless opts[:to] || opts[:redirect_to]

    if opts[:to]
      controller, action = opts[:to].split('#')
      @routes.add_controller_route(method, path, controller, action)
    elsif opts[:redirect_to]
      @routes.add_redirection_route(method, path, opts[:redirected_to])
    end
  end
end
