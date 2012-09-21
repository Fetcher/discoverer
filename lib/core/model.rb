module Core
  # {include:file:docs/Core/Model.md}
  class Model
    include Virtus
    include Reader
    include Writer

    # @!attribute _id
    #   @return [Object] the id of the object as persisted
    attribute :_id

    # Accepts an attributes Hash as argument. Loads from the default datasource
    # unless the Hash has an _id setted.
    #
    # @return [Model] a new instance
    def initialize *args
      super *args
      #binding.pry
      from.default if @_id.nil? and not attributes!.empty?
    end

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