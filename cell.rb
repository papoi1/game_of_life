

class World
  attr_reader :cols_number,  :rows_number

  def initialize(cols, rows)
  @cols_number=cols
  @rows_number=rows
  end

end

class Cell
  attr_reader :actual_status

  def initialize(actual_status=:dead)
    @actual_status=actual_status
    @next_status=@actual_status
  end

  def check_next_status(number_of_neighbours)
    if(@actual_status == :alive && (number_of_neighbours<2 || number_of_neighbours>3))
      @next_status= :dead
    end

    if(@actual_status == :dead && number_of_neighbours == 3)
      @next_status= :alive
    end

    @next_status

  end

end
