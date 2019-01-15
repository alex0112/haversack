describe Sack do
  before(:each) do
    @sack = build(:sack)
  end

  describe '#initialize' do
    context 'when no capacity parameter is present' do
      it 'raises an ArgumentError' do
        expect { Sack.new(10, max_weight: 10) {|i| build(:item) } }.to raise_error ArgumentError
      end
    end

    context 'when no max_weight parameter is present' do
      it 'raises an ArgumentError' do
        expect { Sack.new(10, capacity: 10) }.to raise_error ArgumentError
      end
    end

    context 'when given the capacity and weight parameters' do
      it 'successfully creates a new Sack' do
        expect(Sack.new(10, capacity: 10, max_weight: 10) {|i| build(:item)} ).to be_a_kind_of Sack
      end
    end
  end

  describe '.available_weight' do
    context 'when given a near full sack' do
      let(:near_full_sack) { build(:near_full_sack) }

      it 'calculates the available weight as 1' do
        expect(near_full_sack.available_weight).to be 1
      end
    end
    
    context 'when given a filled sack' do
      let(:filled_sack) { build(:filled_sack) }

      it 'calculates the available weight as 0' do
        expect(filled_sack.available_weight).to be 0
      end
    end
  end
  
  describe '.available_capacity' do
    context 'when given a near full sack' do
      let(:near_full_sack) { build(:near_full_sack) }
      
      it 'calculates the available capacity as 1' do
        expect(near_full_sack.available_capacity).to be 1
      end
    end
    
    context 'when given a filled sack' do
      let(:filled_sack) { build(:filled_sack) }
      
      it 'calculates the available capacity as 0' do
        expect(filled_sack.available_capacity).to be 0
      end
    end

    context 'when given an empty sack with a capacity of 10' do
      let(:empty_sack) { build(:empty_sack) }
      
      it 'calculates the available capacity as 10' do
        expect(empty_sack.available_capacity).to be 10
      end
    end
  end

  describe '.fits_capacity?' do
    let(:near_full_sack) { build(:near_full_sack) }
    
    context 'when the item would exceed capacity' do
      let(:large_item) { build(:large_item) }
      
      it 'returns false' do
        expect(near_full_sack.fits_capacity? large_item).to be false
      end
    end

    context 'when the item would fit capacity' do
      let(:small_item) { build(:item) }
      
      it 'returns true' do
        expect(near_full_sack.fits_capacity? small_item).to be true
      end
    end
  end
  
  describe '.fits_item?' do
    context 'given a non-item' do
      it 'returns false' do
        expect(@sack.fits_item? "").to be false
      end
    end

    ## Skipping.  Tested in .fits_weight? and .fits_capacity?
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
    let(:empty_sack) { build(:empty_sack) }
    
    context 'when pushing an item' do
      it 'pushes an item successfully' do
        expect { empty_sack.push(item) }.not_to raise_error
        expect(empty_sack.include? item).to be true
      end
    end

    context 'when pushing an item that would exceed weight' do
      let(:near_full_sack) { build(:near_full_sack) }
      let(:heavy_item)     { build(:heavy_item) }
      
      it 'raises a KnapsackContentError' do
        expect { near_full_sack.push heavy_item }.to raise_error Haversack::KnapsackContentError
      end
    end

    context 'when pushing an item that would exceed capacity' do
      let(:near_full_sack) { build(:near_full_sack) }
      let(:large_item) { build(:large_item) }

      it 'raises a KnapsackContentError' do
        expect { near_full_sack.push large_item }.to raise_error Haversack::KnapsackContentError
      end
    end
    
  end

  describe '.fits_weight?' do
    let(:near_full_sack) { build(:near_full_sack) }
    let(:heavy_item)     { build(:heavy_item) }
    let(:item)           { build(:item) }
    
    context 'given an item that exceeds weight' do
      it 'returns false' do
        expect(near_full_sack.fits_weight? heavy_item).to be false
      end
    end

    context 'given a set of contents that fits weight' do
      it 'returns true' do
        expect(near_full_sack.fits_weight? item).to be true
      end
    end
  end

  describe '.exceeds_weight?' do
    let(:near_full_sack) { build(:near_full_sack) }
    let(:heavy_item)     { build(:heavy_item) }
    let(:item)           { build(:item) }

    context 'given a set of contents that exceeds weight' do
      it 'returns true' do
        expect(near_full_sack.exceeds_weight? heavy_item).to be true
      end
    end
    
    context 'given a set of contents that fits weight' do
      it 'returns false' do
        expect(near_full_sack.exceeds_weight? item).to be false
      end
    end
  end
  
  describe '.fits_capacity?' do
    let(:near_full_sack) { build(:near_full_sack) }
    let(:large_item)     { build(:large_item) }
    let(:item)           { build(:item) }
    
    context 'given an item that exceeds capacity' do
      it 'returns false' do
        expect(near_full_sack.fits_capacity? large_item).to be false
      end
    end

    context 'given a set of contents that fits weight' do
      it 'returns true' do
        expect(near_full_sack.fits_capacity? item).to be true
      end
    end
  end

  describe '.exceeds_capacity?' do
    let(:near_full_sack) { build(:near_full_sack) }
    let(:large_item)     { build(:large_item) }
    let(:item)           { build(:item) }

    context 'given a set of contents that exceeds weight' do
      it 'returns true' do
        expect(near_full_sack.exceeds_capacity? large_item).to be true
      end
    end
    
    context 'given a set of contents that fits weight' do
      it 'returns false' do
        expect(near_full_sack.exceeds_capacity? item).to be false
      end
    end
  end
  
end
