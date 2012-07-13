require 'log4r'

module Vagrant
  module Action
    module VM
      class DefaultName
        def initialize(app, env)
          @logger = Log4r::Logger.new("vagrant::action::vm::defaultname")
          @app = app
        end

        def call(env)
          @logger.info("Setting the default name of the VM")
          path = env[:root_path].to_s.match(Regexp.new("/[^/]+/#{env[:root_path].basename.to_s}")).to_s.gsub('/','_')
          name =  path + "_#{Time.now.to_i}_#{env[:vm].name}"

          env[:vm].driver.set_name(name)

          @app.call(env)
        end
      end
    end
  end
end
