class Sack
  include Enumerable

  attr_reader :capacity, :weight, :available_capacity, :current_weight, :contents

  def initialize(capacity:, weight:, contents: nil)
    @capacity           = capacity
    @weight             = weight
    self.contents       = contents || [] ## Use the setter to enforce weight/capacity restrictions
    @current_weight     = self.current_weight
    @available_capacity = self.available_capacity
  end

  def method_missing(method_id)
    Enumerable.respond_to? method_id ? @contents.send(method_id) : raise(NoMethodError)
  end
  
  def contents=(new_contents)
    raise Haversack::KnapsackContentError          if has_non_items? new_contents
    raise Haversack::KnapsackCapacityExceededError if exceeds_capacity? new_contents
    raise Haversack::KnapsackWeightExceededError   if exceeds_weight? new_contents
    
    @contents = new_contents
  end

  def has_non_items?(contents) ## TODO: Consider refactor: Static method?  Doesn't rely on instance data.
    contents.any? { |e| !e.is_a? Haversack::Item }
  end

  def current_weight
    @contents.empty? ? 0 : @contents.map { |item| item.weight }.sum
  end

  ## TODO: the *fit* methods duplicate behavior.  Consolidate them in a future itteration.
  
  def fits_item_weight?(item)
    item.weight + @current_weight <= @weight
  end

  def available_capacity
    @contents.empty? ? @capacity : (@capacity - @contents.length)
  end

  def fits_item_capacity?(item)
    item.size < @available_capacity
  end

  def fits_item?(item)
    (item.is_a? Haversack::Item) && (fits_item_capacity?(item) && fits_item_weight?(item))
  end

  def push(item) ## TODO: Return an error that describes which constraint failed
    fits_item? item ? @contents.push(item) : raise(Haversack::KnapsackContentError)
    @contents
  end

  def fits_contents?(contents)
    fits_weight?(contents) && fits_capacity?(contents)
  end

  def fits_weight?(contents)
    new_weight = contents.map { |item| item.weight }.sum
    new_weight <= @weight
  end

  def exceeds_weight?(contents)
    !fits_weight? contents
  end

  def fits_capacity?(contents)
    new_capacity = contents.map { |item| item.size }.sum
    new_capacity <= @capacity
  end

  def exceeds_capacity?(contents)
    !fits_capacity? contents
  end

end
