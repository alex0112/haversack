describe Sack do
  
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
    sack     = create(:sack)
    capacity = sack.capacity
    weight   = sack.weight
    
    context 'when the new contents exceed capacity' do
      contents = Array.new(capacity + 1) { Haversack::Item.new }

      it 'raises a KnapsackCapacityExceededError' do
        expect { sack.contents = contents }.to raise_a Haversack::KnapsackCapacityExceededError
      end
    end

    context 'when the new contents exceed weight' do
      it 'raises a KnapsackWeightExceededError' do
      end
    end

    context 'when at least one member of the contents array is not an Item' do
      it 'raises a KnapsackContentError' do
      end
    end
    
  end

  xdescribe '.has_non_items?' do
    context 'when given a list containing a non-item' do
      it 'returns true' do
      end
    end
  
    context 'when given a list containing only items' do
      it 'returns false' do
      end
    end
  end

  xdescribe '.will_fit_weight?' do
    context 'when the item would exceed weight' do
      it 'returns false' do
      end
    end

    context 'when the item would fit weight' do
      it 'returns true' do
      end
    end
  end

  xdescribe '.will_fit_capacity?' do
    context 'when the item would exceed capacity' do
      it 'returns false' do
      end
    end

    context 'when the item would fit capacity' do
      it 'returns true' do
      end
    end
  end
  
  xdescribe '.will_fit?' do
    context 'given an item that would exceed weight or capacity' do
      it 'returns false' do
      end
    end

    context 'given an item that would fit weight or capacity restricitons' do
      it 'returns true' do
      end
    end
  end

  xdescribe '.push' do
  end

  xdescribe '.fit?' do
  end

  xdescribe '.fits_weight?' do
  end

  xdescribe '.exceeds_weight?' do
  end
  
  xdescribe '.fits_capacity?' do
  end

  xdescribe '.exceeds_capacity?' do
  end
  
end
