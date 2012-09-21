module Core
  # Discoverer Module
  module Reader
    # Discoverer method
    def from
      begin
        @_patterns_reader ||= eval("::Reader::#{self.class}").new self
        @_patterns_reader
      rescue NameError => e 
        raise MissingReaderError, "The reader for #{self.class} (Reader::#{self.class}) wasn't found, please create it"
      end
    end

    class MissingReaderError < StandardError; end
  end
end