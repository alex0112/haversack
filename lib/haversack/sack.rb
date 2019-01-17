require 'haversack/itemcollection'

class Sack < Haversack::ItemCollection

  attr_accessor :capacity
  attr_accessor :max_weight
  
  def initialize(data, capacity:, max_weight:, &block)
    
    @capacity   = capacity
    @max_weight = max_weight
    
    block_given? ? super(data, &block) : super(data)
    
    raise Haversack::KnapsackCapacityExceededError if self_contents_exceed_capacity?
    raise Haversack::KnapsackWeightExceededError   if self_contents_exceed_weight?
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
    item.is_a?(Haversack::Item) &&
      fits_capacity?(item) &&
      fits_weight?(item)
  end
  alias :fits? :fits_item?
  
  def push(item) ## TODO: Describe which constraint failed
    fits_item?(item) ? super : raise(Haversack::KnapsackContentError)
  end

  def contents_fit_weight?(contents)
    is_itemcollection?(contents) ? (contents.weight <= @max_weight) : false
  end

  def contents_fit_capacity?(contents)
    is_itemcollection?(contents) ? (contents.size <= @capacity) : false
  end

  def fits_contents?(contents)
    is_itemcollection?(contents) &&
      contents_fit_capacity?(contents) &&
      contents_fit_weight?(contents)
  end
  
  private
  def is_itemcollection?(contents)
    contents.class.ancestors.include? Haversack::ItemCollection
  end
  

  def self_contents_exceed_weight?
    weight > @max_weight
  end
  
  def self_contents_exceed_capacity?
    size > @capacity
  end
  
end
