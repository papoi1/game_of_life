require_relative '../cell.rb'

describe "A cell" do
    it "starts by default dead" do
      cell = Cell.new

      expect(cell.actual_status).to eq(:dead)
    end

    it "can start alive if alive status is given" do
      cell = Cell.new(:alive)

      expect(cell.actual_status).to eq(:alive)
    end
end

describe "Next status of a cell" do

  context "who is alive" do

    before(:each) do
      @cell = Cell.new(:alive)
    end

    it "will be DEAD with fewer than 2 live neigbours, as if caused by underpopulation" do
      MAX_ALIVE_NEIGHBOURS_FOR_DEAD_CELL_BY_UNDERPOPULATION = 1

      @cell.set_next_status(MAX_ALIVE_NEIGHBOURS_FOR_DEAD_CELL_BY_UNDERPOPULATION)

      expect(@cell.next_status).to eq(:dead)
    end

    it "will be DEAD with more than 3 live neigbours, as if caused by overcrowding" do
      MIN_ALIVE_NEIGHBOURS_FOR_DEAD_CELL_BY_OVERCROWDING = 4

      @cell.set_next_status(MIN_ALIVE_NEIGHBOURS_FOR_DEAD_CELL_BY_OVERCROWDING)

      expect(@cell.next_status).to eq(:dead)
    end

    it "will continue ALIVE with 2 or 3 neigbours alive " do
      IDEAL_ALIVE_NEIGHBOURS_NUMBER_TO_CONTINUE_ALIVE = [2, 3]

      @cell.set_next_status(IDEAL_ALIVE_NEIGHBOURS_NUMBER_TO_CONTINUE_ALIVE[0])

      expect(@cell.next_status).to eq(:alive)
    end
  end

  context "who is dead" do

    before(:each) do
      @dead_cell = Cell.new
    end

    it "will be ALIVE if has 3 live neigbours" do
      NUMBER_OF_ALIVE_NEIGHBOURS_TO_RESURRECT = 3

      @dead_cell.set_next_status(NUMBER_OF_ALIVE_NEIGHBOURS_TO_RESURRECT)

      expect(@dead_cell.next_status).to eq(:alive)
    end
  end

end

describe "A world" do
  before(:each) do
    dimensions = [4, 8]
    @world = World.new(dimensions)
    @total_cells = @world.get_dimensions[0] * @world.get_dimensions[1]
  end

  it "has 2 dimensions" do
    expect(@world.get_dimensions).to eq([4, 8])
  end

  it "allows to add cells on it" do
#MENTORIA: cell o cell.new
    cell = Cell.new # = {actual_status: :dead, next_status: :dead}
    position = [3,7]

    @world.add_cell(cell, position)

    expect(@world.cells[position[0]][position[1]]).to eq(cell)
  end

  it "has all cells dead after populate it" do
    ALIVE_CELLS = 0
    DEAD_CELLS= @total_cells
    @world.populate


    expect(@world.get_dead_cells).to eq(DEAD_CELLS)
    expect(@world.get_alive_cells).to eq(ALIVE_CELLS)
  end

  it "can have dead and alive cells after populate it and add some alive cells" do
    deads = @total_cells
    alives = 0
    @world.populate

    position = [3,7]
    @world.add_cell(Cell.new(:alive), position)
    deads -= 1
    alives += 1

    position = [3,3]
    @world.add_cell(Cell.new(:alive), position)
    deads -= 1
    alives += 1

    expect(@world.get_dead_cells).to eq(deads)
    expect(@world.get_alive_cells).to eq(alives)
  end
end
