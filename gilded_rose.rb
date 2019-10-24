class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
          quality_increase_by_1(item) if is_sell_in_under_11(item) && is_quality_not_max(item)
          quality_increase_by_1(item) if is_sell_in_under_6(item) && is_quality_not_max(item)

      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        sell_in_reduce_by_1(item)
      end


      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
        if is_quality_above_min(item)
          if item.name != "Sulfuras, Hand of Ragnaros"
            quality_reduce_by_1(item)
          end
        end

      else
        if is_quality_not_max(item)
          quality_increase_by_1(item)
        end
      end




      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if is_quality_above_min(item)
              if item.name != "Sulfuras, Hand of Ragnaros"
                quality_reduce_by_1(item)
              end
            end
          else
            quality_set_to_0(item)
          end
        else
          quality_increase_by_1(item) if is_quality_not_max(item)
        end
      end
    end
  end

  def quality_increase_by_1(item)
    item.quality += 1
  end

  def quality_reduce_by_1(item)
    item.quality -= 1
  end

  def quality_set_to_0(item)
    item.quality = 0
  end

  def is_quality_not_max(item)
    item.quality < 50
  end

  def is_quality_above_min(item)
    item.quality > 0
  end

  def is_sell_in_under_11(item)
    item.sell_in < 11
  end

  def is_sell_in_under_6(item)
    item.sell_in < 6
  end

  def sell_in_reduce_by_1(item)
    item.sell_in -= 1
  end






end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end