FactoryBot.define do
  factory :item, class: 'Haversack::Item' do
    weight { 1 }
    size   { 1 }

    factory :large_item do
      size { 2 }
    end

    factory :heavy_item do
      weight { 2 }
    end

    initialize_with { new(weight:weight, size:size) }
  end
end
