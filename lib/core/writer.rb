module Core
  module Writer

    def to
      @_patterns_writer ||= eval("::Writer::#{self.class}").new self
      @_patterns_writer
    end
  end
end