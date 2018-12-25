FactoryBot.define do
  factory :item_collection, class: 'Haversack::ItemCollection' do
    initialize_with { new(10) { build(:item) }  }
  end
  
end
