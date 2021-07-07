require_relative 'route'

class ControllerRoute
  include Route

  def initialize(method, path, controller, action)
    @method = method
    @path = path
    @controller = controller
    @action = action
    @path_regex = path_to_regex(path)
    @param_names = path.scan(/:([\w_]+)/).flatten
  end

  def resolve(path_target)
    require_relative "../../app/controllers/#{@controller}_controller"
    controller = self.class.const_get("#{@controller.capitalize}Controller")
    params = extract_params(path_target)
    controller.new(params).send(@action)
  end
end