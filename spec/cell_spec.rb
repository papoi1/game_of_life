require_relative '../cell.rb'

describe "A WORLD" do
  before(:each) do
    x_dimension = 4
    y_dimension = 8
    @world = World.new(x_dimension, y_dimension)
  end
  
  it "has 2 dimensions" do
    expect(@world.dimensions).to eq([4, 8])
  end
  
  it "adds a cell" do
    cell = {actual_status: :dead, next_status: :dead}
    x_pos = 3
    y_pos = 7
    
    @world.add_cell(cell, x_pos, y_pos)

    expect(@world.cells[y_pos][x_pos]).to eq(cell)
  end
end

describe "A cell" do
    it "starts dead" do
      cell = Cell.new

      expect(cell.actual_status).to eq(:dead)
    end
    it "starts alive" do
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
      @cell.set_next_status(1)

      expect(@cell.next_status).to eq(:dead)
    end

    it "will be DEAD with more than 3 live neigbours, as if caused by overcrowding" do
      @cell.set_next_status(4)

      expect(@cell.next_status).to eq(:dead)
    end

    it "will continue ALIVE with 2 or 3 neigbours " do
      @cell.set_next_status(2)

      expect(@cell.next_status).to eq(:alive)
    end

  end
  context "who is dead" do
    before(:each) do
      @dead_cell = Cell.new
    end

    it "will be ALIVE if has 3 live neigbours" do
      @dead_cell.set_next_status(3)

      expect(@dead_cell.next_status).to eq(:alive)
    end
  end
end
