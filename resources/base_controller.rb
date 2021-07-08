class BaseController

  def initialize(params = {})
    @params = params.transform_keys(&:to_sym)
  end

  def render(view, opts={})
    require_relative "../app/views/#{controller_name}/#{view}"
    view_class = self.class.const_get(view.to_s.split('_').map(&:capitalize).join)
    view_instance = view_class.new
    instanciate_variables(view_instance)
    view_instance.render
  end

  def redirect_to(path)
    BaseView.new.redirect_to(path)
  end

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end

  private

  def instanciate_variables(view)
    instance_variables.each do |var|
      view.instance_variable_set(var, instance_variable_get(var))
    end
  end
end