module Core
  module Writer

    def from
      @_patterns_writer ||= eval("::Writer::#{self.class}").new self
      @_patterns_writer
    end
  end
end