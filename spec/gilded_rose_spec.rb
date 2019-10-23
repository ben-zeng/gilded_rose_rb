require './gilded_rose'

describe GildedRose do

  describe '#update_quality' do
    describe 'naming' do
      it 'does not change the name' do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].name).to eq "foo"
      end
    end

    describe 'for normal items' do
      it 'reduces sell_in value by 1' do
        items = [Item.new("foo", 1, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 0
      end

      it 'reduces quality value by 1' do
        items = [Item.new("foo", 0, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end
  end
end
