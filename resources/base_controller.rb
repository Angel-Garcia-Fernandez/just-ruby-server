class BaseController

  def initialize(params = {})
    @params = params
  end

  def render(view, opts={})
    require_relative "../app/views/#{controller_name}/#{view}"
    view_class = self.class.const_get(view.to_s.split('_').map(&:capitalize).join)
    view_class.new(@params).render
  end

  def controller_name
    self.class.to_s.downcase.gsub('controller', '')
  end
end