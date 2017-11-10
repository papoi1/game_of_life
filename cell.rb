require './draw.rb'

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


class World
  attr_reader :cells

    def initialize(dimensions)
    @rows_of_world = dimensions[0]
    @cols_of_world = dimensions[1]
    @cells = Array.new(@rows_of_world) { Array.new(@cols_of_world) }
    end

  def get_dimensions
    [@rows_of_world, @cols_of_world]
  end

  def add_cell(cell, position)
    @cells[position[0]][position[1]] = cell
  end

  def populate
    @cells.map! {|row|
      row.map! { |item| Cell.new
      }
    }
  end

  def get_dead_cells
    number_of_dead_cells = 0
    @cells.each { |row|
      row.each { |col|
        if col.actual_status == :dead
          number_of_dead_cells +=1
        end

      }
    }
    number_of_dead_cells
  end

  def get_alive_cells
        number_of_alive_cells = 0
        @cells.each { |row|
          row.each { |col|
            if col.actual_status == :alive
              number_of_alive_cells +=1
            end

          }
        }
        number_of_alive_cells

  end

end
