FactoryBot.define do
  factory :sack do
    capacity { 10 }
    weight   { 10 }

    factory :filled_sack do
      contents { Array.new(capacity) { create(:item) } }
    end

  end
end
