class BaseRoutes
  def self.get(path, opts={})
    controller, action = opts[:to].split('#')
    require_relative "../app/controllers/#{controller}_controller"
    "#{controller.capitalize}Controller".constantize.send(action)
  end
end