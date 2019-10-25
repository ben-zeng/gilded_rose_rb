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

      it 'quality never becomes negative' do
        items = [Item.new("foo", 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end

    describe 'for "Aged Brie"' do
      it 'quality increases instead of decreases' do
        items = [Item.new("Aged Brie", 1, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
      end

      it 'quality is never more than 50' do
        items = [Item.new("Aged Brie", 1, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end

    describe 'for "Sulfuras, Hand of Ragnaros"' do
      it 'quality always stay the same' do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 90)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 90
      end
    end

    describe 'for "Backstage passes to a TAFKAL80ETC concert"' do
      it 'quality increases by 1 when more than 10 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 15)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 16
      end
      it 'quality increases by 2 when between 6 and 10 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 17)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 19
      end
      it 'quality increases by 3 when between 1 and 5 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 17)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 20
      end
      it 'quality drops to 0 when between 0 days left' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 17)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
      it 'quality is never more than 50' do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end
    end


    describe 'after sell by date, quality degrades twice as fast' do
      it 'normal items reduces quality value by 2' do
        items = [Item.new("foo", -1, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
      end
    end

    describe 'for Conjured items, quality reduces twice as fast' do
      it 'when sell_in above 0' do
        items = [Item.new("Conjured item", 2, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
      end

      it 'when sell_in is 0, ' do
        items = [Item.new("Conjured item", 0, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq -1
      end

      it 'when sell_in below 0, ' do
        items = [Item.new("Conjured item", 2, 3)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq -1
      end
    end

  end


end

