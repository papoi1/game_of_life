class World
  def draw(symbol_dead, symbol_alive)
    result = ""
    @cells.each { |row|
      row.each { |item|
        item_st = symbol_alive
        if item.get_actual_status == :dead then item_st = symbol_dead end
        result = result + item_st
      }
      result = result + "\n"
    }
    result.chomp
  end
end
