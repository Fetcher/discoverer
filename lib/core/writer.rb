module Core
  module Writer

    def to
      begin
        @_writer ||= Discoverer.for(::Writer, self.class).new self
        @_writer
      rescue Core::Discoverer::NotFoundError => e 
        raise MissingWriterError, "The writer for #{self.class} (Writer::#{self.class}) wasn't found, please create it"
      end
    end

    class MissingWriterError < StandardError; end
    class EmptySourceError < StandardError; end
  end
end