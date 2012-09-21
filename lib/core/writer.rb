module Core
  module Writer

    def to
      begin
        @_patterns_writer ||= eval("::Writer::#{self.class}").new self
        @_patterns_writer
      rescue
        raise MissingWriterError, "The writer for #{self.class} (Writer::#{self.class}) wasn't found, please create it"
      end
    end

    class MissingWriterError < StandardError; end
  end
end