module Core
  module Discoverer
    module Writer

      # @return [TrueClass, FalseClass] returns true if there is a corresponding 
      #   Writer for this class, false otherwise      
      def has_writer?
        namespace = self.name.split '::'
        current_module = ::Writer
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

      # @return [Writer] returns the corresponding writer for this class, 
      #   unless there is no writer for self nor for any of its ancestors
      def writer original_class = self
        if self.has_writer?
          eval "::Writer::#{self.name}"
        else
          self.ancestors.length.times do |time|
            unless time == 0
              if self.ancestors[time].respond_to? :writer
                return self.ancestors[time].writer original_class
              end
            end
          end

          raise NotFoundError, 
            "There is no writer for #{original_class} or any of its ancestors"
        end
      end

      class NotFoundError < StandardError; end      
    end
  end
end