FactoryBot.define do
  factory :sack do
    capacity   { 10 }
    max_weight { 10 }
    
    
    initialize_with { new(10, capacity:capacity, max_weight:max_weight) {|i| build(:item) } }

    factory :empty_sack do
      initialize_with { new(0, capacity:capacity, max_weight:max_weight) {|i| build(:item) } }
    end

    factory :filled_sack do
      initialize_with { new(capacity, capacity:capacity, max_weight:max_weight) { build(:item) } }
    end

    factory :near_full_sack do
      initialize_with { new(capacity - 1, capacity:capacity, max_weight:max_weight) { build(:item) } }
    end
  end
end
