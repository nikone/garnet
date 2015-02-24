require "garnet/version"
require "garnet/controller"
require "garnet/utils"
require "garnet/dependencies"
require "garnet/router"

module Garnet
  class Application
    def call(env)
      if env["PATH_INFO"] == "/favicon.ico"
        return [500, {}, []]
      end

      get_rack_app(env).call(env)
    end
  end
end
