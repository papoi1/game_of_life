require_relative '../cell.rb'

describe "A WORLD" do
  it "has 2 dimensions" do
    world= World.new(8,4)
    expect(world.cols_number).to eq(8)
    expect(world.rows_number).to eq(4)
  end
end


describe "A cell" do
    it "starts dead" do
      cell = Cell.new
      expect(cell.actual_status).to eq(:dead)
    end
    it "starts alive" do
      cell= Cell.new(:alive)
      expect(cell.actual_status).to eq(:alive)
    end
end

describe "Next status of a cell" do

  context "who is alive" do

    before(:each) do
      @cell=Cell.new(:alive)
    end

    it "will be DEAD with fewer than 2 live neigbours, as if caused by underpopulation" do
      expect(@cell.check_next_status(1)).to eq(:dead)
    end

    it "will be DEAD with more than 3 live neigbours, as if caused by overcrowding" do
      expect(@cell.check_next_status(4)).to eq(:dead)
    end

    it "will continue ALIVE with 2 or 3 neigbours " do
      expect(@cell.check_next_status(2)).to eq(:alive)
    end

  end
  context "who is dead" do
    before(:each) do
      @dead_cell=Cell.new
    end

    it "will be ALIVE if has 3 live neigbours" do
      expect(@dead_cell.check_next_status(3)).to eq(:alive)
    end
  end
end
