class Cell
  MIN_NEIGHBOURS_TO_BE_ALIVE = 2
  MAX_NEIGHBOURS_TO_BE_ALIVE = 3
  NEIGHBOURS_TO_RESURRECT = 3

  def initialize(initial_status)
    @actual_status = initial_status
    @next_status = @actual_status
    @live_neighbours = 0
  end

  def status
    @actual_status
  end

  def change_status
    @next_status =  @actual_status == :alive ? :dead : :alive
  end

  def next_status
    self.change_status?

    @next_status
  end

  def set_live_neighbours(live_cells)
    @live_neighbours = live_cells
  end

  def change_status?
    if (@actual_status == :alive && @live_neighbours < MIN_NEIGHBOURS_TO_BE_ALIVE) then self.change_status end
    if (@actual_status == :alive && @live_neighbours > MAX_NEIGHBOURS_TO_BE_ALIVE) then self.change_status end
    if (@actual_status == :dead && @live_neighbours == NEIGHBOURS_TO_RESURRECT) then self.change_status end
  end

end
