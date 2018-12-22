describe Sack do
  before(:each) do
    @sack = build(:sack)
  end

  describe '#initialize' do
    context 'when no capacity parameter is present' do
      it 'raises an ArgumentError' do
        expect { Sack.new(weight: 10) }.to raise_error ArgumentError
      end
    end

    context 'when no weight parameter is present' do
      it 'raises an ArgumentError' do
        expect { Sack.new(capacity: 10) }.to raise_error ArgumentError
      end
    end

    context 'when given the capacity and weight parameters' do
      it 'successfully creates a new empty Sack' do
        expect(Sack.new(capacity: 10, weight: 10)).to be_a_kind_of Sack
      end
    end
  end

  describe '.contents=' do
    let(:contents)          { @sack.contents }
    let(:capacity)          { @sack.capacity }
    let(:weight)            { @sack.weight }
    let(:exceeded_capacity) { Array.new(capacity + 1) { build(:item) } }
    let(:exceeded_weight)   { Array.new(capacity) { build(:item, weight: weight + 1) } }
    let(:non_item_contents) { Array.new(5) }
    let(:item_contents)     { Array.new(5) { build(:item) } }
    
    context 'when the new contents exceed capacity' do
      it 'raises a KnapsackCapacityExceededError' do
        expect { @sack.contents = exceeded_capacity }.to raise_error Haversack::KnapsackCapacityExceededError
      end

    end

    context 'when the new contents exceed weight' do
      it 'raises a KnapsackWeightExceededError' do
        expect { @sack.contents = exceeded_weight }.to raise_error Haversack::KnapsackWeightExceededError
      end
    end

    context 'when at least one member of the contents array is not an Item' do
      it 'raises a KnapsackContentError' do
        expect { @sack.contents = non_item_contents }.to raise_error Haversack::KnapsackContentError
      end
    end
    
  end

  describe '.has_non_items?' do
    let(:non_item_contents) { Array.new(5) }
    let(:item_contents)     { Array.new(5) { build(:item) } }

    context 'when given a list containing a non-item' do
      it 'returns true' do
        expect(@sack.has_non_items? non_item_contents).to be true
      end
    end
  
    context 'when given a list containing only items' do
      it 'returns false' do
        expect(@sack.has_non_items? item_contents).to be false
      end
    end
  end

  describe '.current_weight' do
    let(:filled_sack) { build(:filled_sack) }
    let(:empty_sack)  { build(:sack) }
    
    context 'when given a sack with a total weight of 10' do
      it 'calculates the current weight as 10' do
        expect(filled_sack.current_weight).to be 10
      end
    end

    context 'when given an empty sack' do
      it 'calculates the current weight as 0' do
        expect(empty_sack.current_weight).to be 0
      end
    end
    
  end

  describe '.fits_item_weight?' do
    let(:overweight_item)    { build(:item, weight: @sack.weight + 1) }
    let(:within_weight_item) { build(:item) }

    context 'when the item would exceed weight' do
      it 'returns false' do
        expect(@sack.fits_item_weight? overweight_item).to be false
      end
    end

    context 'when the item would fit weight' do
      it 'returns true' do
        expect(@sack.fits_item_weight? within_weight_item).to be true
      end
    end
  end

  describe '.available_capacity' do
    let(:empty_sack)     { build(:sack) }
    let(:filled_sack)    { build(:filled_sack) }
    let(:near_full_sack) { build(:near_full_sack) }

    context 'when given a near full sack' do
      it 'calculates the available capacity as 1' do
        expect(near_full_sack.available_capacity).to be 1
      end
    end
    
    context 'when given a filled sack' do
      it 'calculates the current capacity as 0' do
        expect(filled_sack.available_capacity).to be 0
      end
    end

    context 'when given an empty sack with a capacity of 10' do
      it 'calculates the available capacity as 10' do
        expect(empty_sack.available_capacity).to be 10
      end
    end

  end


  describe '.fits_item_capacity?' do
    let(:near_full_sack) { build(:near_full_sack) }
    let(:large_item)     { build(:large_item, size: 10) }
    let(:small_item)     { build(:item) }
    
    context 'when the item would exceed capacity' do
      it 'returns false' do
        expect(near_full_sack.fits_item_capacity? large_item).to be false
      end
    end

    context 'when the item would fit capacity' do
      it 'returns true' do
        expect(near_full_sack.fits_item_capacity? small_item).to be true
      end
    end
  end
  
  describe '.fits_item?' do
    context 'given a non-item' do
      it 'returns false' do
        expect(@sack.fits_item? "").to be false
      end
    end

    ## Skipping.  Tested in .fits_item_weight? and .fits_item_capacity?
    xcontext 'given an item that would exceed weight' do 
      it 'returns false' do
      end
    end

    xcontext 'given an item that would fit weight' do
      it 'returns true' do
      end
    end

    xcontext 'given an item that would exceed capacity' do
      it 'returns false' do
      end
    end
    
    xcontext 'given an item that would fit capacity' do
      it 'returns true' do
      end
    end
  end

  describe '.push' do
    let(:item)       { build(:item) }
    let(:large_item) { build(:large_item) }

    it 'pushes an item successfully' do
      @sack.push item
      expect(@sack.contents.include? item).to be true
    end
    
  end

  xdescribe '.fits_contents?' do
  end

  describe '.fits_weight?' do
    let(:exceeds_weight_contents) { Array.new(@sack.capacity) { build(:heavy_item) } }
    let(:fits_weight_contents)    { Array.new(@sack.capacity) { build(:item) } }
    
    context 'given a set of contents that exceeds weight' do
      it 'returns false' do
        expect(@sack.fits_weight? exceeds_weight_contents).to be false
      end
    end

    context 'given a set of contents that fits weight' do
      it 'returns true' do
        expect(@sack.fits_weight? fits_weight_contents).to be true
      end
    end
  end

  describe '.exceeds_weight?' do
    let(:exceeds_weight_contents) { Array.new(@sack.capacity) { build(:heavy_item) } }
    let(:fits_weight_contents)    { Array.new(@sack.capacity) { build(:item) } }
    
    context 'given a set of contents that exceeds weight' do
      it 'returns true' do
        expect(@sack.exceeds_weight? exceeds_weight_contents).to be true
      end
    end
    
    context 'given a set of contents that fits weight' do
      it 'returns false' do
        expect(@sack.exceeds_weight? fits_weight_contents).to be false
      end
    end
  end
  
  describe '.fits_capacity?' do
    let(:exceeds_capacity_contents) { Array.new(@sack.capacity) { build(:large_item) } }
    let(:fits_capacity_contents)    { Array.new(@sack.capacity) { build(:item) } }
    
    context 'given a set of contents that exceeds capacity' do
      it 'returns false' do
        expect(@sack.fits_capacity? exceeds_capacity_contents).to be false
      end
    end

    context 'given a set of contents that fits capacity' do
      it 'returns true' do
        expect(@sack.fits_capacity? fits_capacity_contents).to be true
      end
    end
  end

  describe '.exceeds_capacity?' do
    let(:exceeds_capacity_contents) { Array.new(@sack.capacity) { build(:large_item) } }
    let(:fits_capacity_contents)    { Array.new(@sack.capacity) { build(:item) } }
    
    context 'given a set of contents that exceeds capacity' do
      it 'returns true' do
        expect(@sack.exceeds_capacity? exceeds_capacity_contents).to be true
      end
    end

    context 'given a set of contents that fits capacity' do
      it 'returns false' do
        expect(@sack.exceeds_capacity? fits_capacity_contents).to be false
      end
    end
    
  end
  
end
