module Core
  class Model
    include Virtus

    attribute :_id

    # @return [Hash] The attributes which are not set to nil
    def attributes!
      the_attributes = {}
      attributes.each do |key, value|
        the_attributes[key] = value unless value.nil?
      end
      return the_attributes
    end
  end
end