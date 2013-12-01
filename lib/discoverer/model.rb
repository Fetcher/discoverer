module Discoverer
  # {include:file:docs/Discoverer/Model.md}
  class Model
    include Virtus.model
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

    # Static methods
    # @return [Symbol] the name of the class, pluralized, downcased and made into a Symbol
    def self.table_name
      "#{self.downcase}s".to_sym
    end

    # @return [String] the name of the clasee, downcased and made into a String
    def self.downcase 
      "#{self}".split("::").last.downcase
    end
  end
end
