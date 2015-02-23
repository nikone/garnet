require "garnet/version"
require "garnet/controller"
require "garnet/utils"
require "garnet/dependencies"

module Garnet
  class Application
    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [500, {}, []]
      end

      controller_class, action = get_controller_and_action(env)
      controller = controller_class.new(env)
      response = controller.send(action)

      if controller.get_response
        controller.get_response
      else
        controller.render(action)
        controller.get_response
        #['200', {'Content-Type' => 'text/html'}, [response]]
      end
    end

    def get_controller_and_action(env)
      _, controller_name, action = env["PATH_INFO"].split('/')
      controller_name = controller_name.to_camel_case + "Controller"
      [Object.const_get(controller_name), action]
    end
  end
end
