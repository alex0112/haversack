class Sack
  include Enumerable
  attr_reader :capacity
  attr_reader :weight
  attr_reader :contents
  
  def initialize(capacity:, weight:, contents: nil)
    @capacity     = capacity
    @weight       = weight
    self.contents = contents || [] ## Use the setter to enforce weight/capacity restrictions
  end

  def method_missing(method_id)
    @contents.send(method_id)
  end
  
  def contents=(new_contents)
    raise Haversack::KnapsackCapacityExceededError if exceeds_capacity? new_contents
    raise Haversack::KnapsackWeightExceededError   if exceeds_weight? new_contents
    raise Haversack::KnapsackContentError          if has_non_items? new_contents
    
    @contents = new_contents
  end

  def has_non_items?(contents)
    contents.any? { |e| !e.is_a? Haversack::Item }
  end

  def will_fit_weight?(item)
  end

  def will_fit_capacity?(item)
  end

  def will_fit?(item)
    item.is_a? Item && @contents.length + 1 <= @capacity
  end

  def push(item)
    will_fit? item ? @contents.push(item) : raise(Haversack::KnapsackContentError) ## TODO: This should return an error that describes wether the weight or capacity constraint failed
    @contents
  end

  def fit?(contents)
    fits_weight?(contents) && fits_capacity?(contents)
  end
  alias_method :fits?, :fit?

  def fits_weight?(contents)
    new_weight = contents.map { |item| item.weight }.sum
    new_weight <= @weight
  end

  def exceeds_weight?(contents)
    !fits_weight? contents
  end

  def fits_capacity?(contents)
    contents.length <= @capacity
  end

  def exceeds_capacity?(contents)
    !fits_capacity? contents
  end

end
