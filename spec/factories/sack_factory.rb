FactoryBot.define do
  factory :sack do
    capacity { 10 }
    weight   { 10 }

    initialize_with { new(capacity:capacity, weight:weight) }
    
    factory :filled_sack do
      contents { Array.new(capacity) { build(:item) } }
    end

    factory :near_full_sack do
      contents { Array.new(capacity - 1) { build(:item) } }
    end
  end
end
