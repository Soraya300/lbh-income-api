module Hackney
  module UniversalHousing
    class Client
      class << self
        def connection
          Sequel.connect(configuration)
        end

        private

        def configuration
          @configuration ||= begin
            config_file = File.read(Rails.root.join('config', 'database_universal_housing.yml'))
            env_config = YAML.safe_load(ERB.new(config_file).result, [], [], true)[Rails.env.to_s]
            env_config.symbolize_keys
          end
        end
      end
    end
  end
end
