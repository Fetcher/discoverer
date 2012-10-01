module Core
  module Discoverer
    # Writer Discoverer mixin that Core includes into Class    
    module Writer
      # @return [TrueClass, FalseClass] returns true if there is a corresponding 
      #   Writer for this class, false otherwise      
      def has_writer?
        Discoverer.has_adapter_for? ::Writer, self
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