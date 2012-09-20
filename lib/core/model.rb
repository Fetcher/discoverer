module Core
  class Model
    include Virtus

    attribute :_id

    # @return [Hash] The attributes which are not set to nil
    def attributes!
    end
  end
end