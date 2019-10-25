class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_quality_backstage_pass(item)
      elsif item.name == "Aged Brie"
        quality_increase_by_1(item)
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        p "Sulfuras is legendary, nothing happens to it"
      else
        item.sell_in -= 1
        item.sell_in < 0 ? 2.times {quality_reduce_by_1(item)} : quality_reduce_by_1(item)
      end
    end
  end

  def update_quality_backstage_pass(item)
    if item.sell_in > 10
      quality_increase_by_1(item)
    elsif item.sell_in.between?(6,10)
      2.times { quality_increase_by_1(item) }
    elsif item.sell_in.between?(1,5)
      3.times { quality_increase_by_1(item) }
    else
      item.quality = 0
    end
  end

  def quality_increase_by_1(item)
    item.quality += 1 if is_quality_not_max(item)
  end

  def quality_reduce_by_1(item)
    item.quality -= 1 if is_quality_above_min(item)
  end

  def is_quality_not_max(item)
    item.quality < 50
  end

  def is_quality_above_min(item)
    item.quality > 0
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