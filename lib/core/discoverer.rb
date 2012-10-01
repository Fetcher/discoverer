module Core
  module Discoverer
    def self.has_adapter_for? adapter_constant, the_class
      namespace = the_class.name.split '::'
      current_module = adapter_constant
      until namespace.empty?
        if RUBY_VERSION =~ /1.8/
          return false unless current_module.constants.include? namespace.first 
        else
          return false unless current_module.constants.include? namespace.first.to_sym
        end
        current_module = current_module.const_get namespace.shift
      end
      return true
    end
  end
end