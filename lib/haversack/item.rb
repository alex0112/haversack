module Haversack
  class Item
    attr_accessor :weight
    attr_accessor :size
    attr_accessor :data
    
    def initialize(weight: 1, size: 1, data: nil)
      @weight = weight
      @size   = size
      @data   = data
    end
  end
end
