require 'haversack/itemcollection'

class Sack < Haversack::ItemCollection

  attr_accessor :capacity
  attr_accessor :max_weight
  
  def initialize(data, capacity:, max_weight:, &block)
    
    @capacity   = capacity
    @max_weight = max_weight
    
    block_given? ? super(data, &block) : super(data)
    
    raise Haversack::KnapsackCapacityExceededError if contents_exceed_capacity?
    raise Haversack::KnapsackWeightExceededError   if contents_exceed_weight?
    end

  def available_weight
    empty? ? @max_weight : (@max_weight - weight)
  end

  def available_capacity
    empty? ? @capacity : (@capacity - size)
  end

  def fits_weight?(item)
    item.weight <= available_weight
  end

  def exceeds_weight?(item)
    !fits_weight?(item)
  end
  
  def fits_capacity?(item)
    item.size <= available_capacity
  end

  def exceeds_capacity?(item)
    !fits_capacity?(item)
  end
    
  def fits_item?(item)
    item.is_a?(Haversack::Item) && fits_capacity?(item) && fits_weight?(item)
  end
  alias :fits? :fits_item?
  
  def push(item) ## TODO: Describe which constraint failed
    fits_item?(item) ? super : raise(Haversack::KnapsackContentError)
  end
  
  private
  def contents_exceed_weight?
    weight > @max_weight
  end
  
  def contents_exceed_capacity?
    size > @capacity
  end
  
end
