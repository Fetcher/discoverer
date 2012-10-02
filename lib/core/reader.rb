module Core
  
  # Discoverer Method implementation for Readers
  # Implements method #from
  module Reader

    # Discoverer method
    # @return [Reader] the reader object for this object, initialized
    def from
      begin
        @_reader ||= Discoverer.for( ::Reader, self.class ).new self
        @_reader
      rescue Core::Discoverer::NotFoundError => e 
        raise MissingReaderError, "The reader for #{self.class} (Reader::#{self.class}) wasn't found, please create it"
      end
    end

    class MissingReaderError < StandardError; end
  end
end