

class World
  attr_reader :cells

    def initialize(dimensions)
    @cols_of_world = dimensions[0]
    @rows_of_world = dimensions[1]
    @cells = Array.new(@rows_of_world) { Array.new(@cols_of_world) }
    end

  def dimensions
    [@cols_of_world, @rows_of_world]
  end

  def add_cell(cell, position)
    @cells[position[0]][position[1]] = cell
  end

  def populate

    p "impresion de la cell:\n"
    p @cells[0][0]
    fila= 0
    col= 0
    @cells.each { |row|
      row.each { |item|
      p  item
      }
    }
    p "======"

    @cells.each { |row|
      row.each { |item|
        @cells[fila][col] = Cell.new
        col+=1
      }
      fila+=1
    }
    # position = [0,1]
    # add_cell(cell, position)
   # puts @cells[0][0].actual_status

  end

  def get_dead_cells

    number_of_dead_cells = 0
    @cells.each { |row|
      row.each { |col|
        p col
        # return number_of_dead_cells unless col.respond_to?(actual_status)
        if (col.respond_to?(:actual_status) && col.actual_status == :dead )
          number_of_dead_cells +=1
          p col.actual_status
        end
      }
    }
    p number_of_dead_cells
    number_of_dead_cells
  end

  def get_alive_cells
    0
  end

end

class Cell
  attr_reader :actual_status, :next_status

  def initialize(actual_status = :dead)
    @actual_status = actual_status
    @next_status = @actual_status

  end

  def set_next_status(number_of_neighbours)
    if(@actual_status == :alive && (number_of_neighbours < 2 || number_of_neighbours > 3))
      return @next_status = :dead
    end

    if(@actual_status == :dead && number_of_neighbours == 3)
      @next_status= :alive
    end

  end

end
