module Haversack

  class Item
    attr_accessor :weight
    attr_accessor :data
    
    def initialize(weight:, data: nil)
      @weight = weight
      @data   = data
    end
  end

end
