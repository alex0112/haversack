class ChildCollection < Haversack::ItemCollection  ## Bloody Hack.
end

FactoryBot.define do
  factory :item_collection, class: 'Haversack::ItemCollection' do
    initialize_with { new(10) { build(:item) }  }

    factory :huge_contents do
      initialize_with { new(50) { build(:item) } }
    end

    factory :small_contents do
      initialize_with { new(1) { build(:item) } }
    end

    
  end

  factory :child, class: 'ChildCollection' do
    initialize_with { new(10) { build(:item) }  }
  end
  
end

