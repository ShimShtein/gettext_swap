require 'gettext_swap/exceptions'

module GettextSwap
  class Configuration
    attr_reader :rules

    def initialize
      @rules = []
    end

    def read_yaml(yaml)
      root = yaml['swap']

      raise(
        GettextSwap::Exception,
        "root 'swap' element must be specified") unless root
      # Be atomic, either load the whole file, or don't load it at all
      tuples = root.map { |tuple| read_tuple(tuple) }
      @rules = tuples.freeze
      true
    end

    private

    def read_tuple(tuple)
      regex = tuple['search']
      value = tuple['replace']

      raise(
        GettextSwap::Exception,
        "search element must be specified for tuple #{tuple}") unless regex
      raise(
        GettextSwap::Exception,
        "replace element must be specified for tuple #{tuple}") unless value

      [Regexp.new(regex), value]
    end
  end

  # declare private module methods.
  class << self
    def rules
      configuration.rules
    end

    def configure(path_to_yaml)
      yaml = YAML.load(IO.read(path_to_yaml))
      configuration.read_yaml(yaml)
    end

    private

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
