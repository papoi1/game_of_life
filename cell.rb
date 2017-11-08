

class World
  attr_reader :cells

  def initialize(x_dimension, y_dimension)
    @cells = Array.new(y_dimension) { Array.new(x_dimension) }
  end

  def dimensions
    y_dimension = @cells.size
    x_dimension = @cells[0].size
    [x_dimension, y_dimension]
  end

  def add_cell(cell, x_dimension, y_dimension)
    @cells[y_dimension][x_dimension] = cell
  end

  def populate
    cell = Cell.new
    add_cell(cell, 0, 0)
#    puts @cells[0][0].actual_status

  end

  def get_dead_cells

    number_of_dead_cells = 0
    @cells.each { |row|
      row.each { |cell|
         return unless cell.respond_to?(actual_status)
         if col.actual_status == :dead
           number_of_dead_cells +=1
         end
      }
    }
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
