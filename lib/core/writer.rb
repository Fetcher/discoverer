module Core
  module Writer

    def to
      begin
        @_writer ||= self.class.writer.new self
        @_writer
      rescue
        raise MissingWriterError, "The writer for #{self.class} (Writer::#{self.class}) wasn't found, please create it"
      end
    end

    class MissingWriterError < StandardError; end
    class EmptySourceError < StandardError; end
  end
end