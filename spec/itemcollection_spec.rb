describe Haversack::ItemCollection do

  before(:each) do
    @collection = build(:item_collection)
  end
  
  describe '#initialize' do
    context 'when given a block' do
      it 'instantiates an ItemCollection' do
        expect( Haversack::ItemCollection.new(10) { |i| build(:item) } ).to be_a Haversack::ItemCollection
      end
    end
    
    context 'when given an array of items' do
      let(:item_arr) { Array.new(10) { build(:item) } }
      
      it 'instantiates an ItemCollection' do
        expect( Haversack::ItemCollection.new(item_arr) ).to be_a Haversack::ItemCollection
      end
    end
  end

  describe '.size' do
    context 'given an item array with a total size of 10' do
      let(:item_arr_10) { Array.new(10) { build(:item, size: 1) } }
      let(:size_10_collection) { Haversack::ItemCollection.new(item_arr_10) }
      
      it 'calculates the size as 10' do
        expect(size_10_collection.size).to be 10
      end
    end
  end

  describe 'weight' do
    context 'given an item array with a total weight of 10' do
      let(:item_arr_10) { Array.new(10) { build(:item, weight: 1) } }
      let(:weight_10_collection) { Haversack::ItemCollection.new(item_arr_10) }
      
      it 'calculates the size as 10' do
        expect(weight_10_collection.weight).to be 10
      end
    end
  end

  describe '.push' do
    context 'when pushing a non-item' do
      it 'should raise an error' do
        expect { @collection.push String.new }.to raise_error Haversack::KnapsackContentError
      end
    end

    context 'when pushing an item' do
      let(:uniq_item) { build(:item) }

      it 'adds the new item to the collection' do
        expect { @collection.push(uniq_item) }.not_to raise_error
        expect(@collection.last).to eql uniq_item
      end
    end
    
  end
  
end
