module Discoverer
  def self.has_adapter_for? adapter_constant, the_class
    return false if the_class.name.nil?
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

  def self.for adapter_constant, the_class
    the_class.ancestors.length.times do |time|
      if has_adapter_for? adapter_constant, the_class.ancestors[time]
        return eval "::#{adapter_constant}::#{the_class.ancestors[time]}"
      end
    end

    raise NotFoundError, 
      "There is no #{adapter_constant.name.downcase} for #{the_class} or any of its ancestors"
  end

  class NotFoundError < StandardError; end
end
