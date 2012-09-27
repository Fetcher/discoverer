module Core
  module Discoverer
    # Reader Discoverer mixin that Core includes into Class
    module Reader
      # @return [TrueClass, FalseClass] returns true if there is a corresponding 
      #   Reader for this class, false otherwise
      def has_reader?
        namespace = self.name.split '::'
        current_module = ::Reader
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

      # @return [Reader] returns the corresponding reader for this class, 
      #   unless there is no reader for self nor for any of its ancestors
      def reader original_class = self
        if self.has_reader?
          eval "::Reader::#{self.name}"
        else
          self.ancestors.length.times do |time|
            unless time == 0
              if self.ancestors[time].respond_to? :reader
                return self.ancestors[time].reader original_class
              end
            end
          end

          raise NotFoundError, 
            "There is no reader for #{original_class} or any of its ancestors"
        end
      end

      class NotFoundError < StandardError; end
    end
  end
end