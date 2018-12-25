module Haversack
  class ItemCollection < Array

    def initialize(data, &block)
      if !block_given?
        raise ArgumentError, "expected #{data} to contain only elements of class Haversack::Item" unless data.is_a?(Array) && only_items?(data)
      end

      @size   = self.size
      @weight = self.weight

      block_given? ? super(data, block) : super(data)
    end

    def size
      map(&:size).sum
    end

    def weight
      map(&:weight).sum
    end

    def push(obj)
      raise Haversack::KnapsackContentError unless obj.is_a? Haversack::Item
      super
    end

    private
    def only_items?(data)
      data.all? { |el| el.is_a? Haversack::Item }
    end
    
  end
end
