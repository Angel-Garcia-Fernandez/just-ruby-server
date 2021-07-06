class BaseRoutes
  METHODS = [
    GET = 'GET',
    POST = 'POST',
    PUT = 'PUT',
    DELETE = 'DELETE'
  ]

  class RoutesHash
    def initialize
      @hash = { GET => {}, POST => {}, PUT => {}, DELETE => {} }
    end

    def add(method, path, controller, action)
      @hash[method][path] = [controller, action]
    end

    def get(method, request_line)
      @hash[method][request_line]
    end
  end

  def initialize
    @routes = RoutesHash.new
    define_routes
  end

  def resolve(method_token, request_line)
    controller, action = @routes.get(method_token, request_line)
    return unless controller && action

    require_relative "../app/controllers/#{controller}_controller"
    self.class.const_get("#{controller.capitalize}Controller").send(:new).send(action)
  end

  private

  def get(path, opts={})
    controller, action = opts[:to].split('#')
    @routes.add(GET, path, controller, action)
  end

  def define_routes; end
end
