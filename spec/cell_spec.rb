require_relative '../cell.rb'

describe "When a cell" do
  context "is created with initial status" do
    it "the status can be retrieved" do
      cell = Cell.new(:alive)
#sdfasdfasdfxzfgsdfgs aproach1 ready for commit
#teteo
      expect(cell.status).to eq(:alive)

      cell = Cell.new(:dead)
#     p cell.class
      expect(cell.status).to eq(:dead)
    end

    it "the next status can be set" do
      cell = Cell.new(:alive)

      cell.change_status

      expect(cell.next_status).to eq(:dead)

      cell = Cell.new(:dead)

      cell.change_status

      expect(cell.next_status).to eq(:alive)
    end
  end

  context "is alive" do
    it "with fewer than two live neighbours will die (underpopulation)" do
      cell = Cell.new(:alive)

      neighbours_for_underpopulation = 1
      cell.set_live_neighbours(neighbours_for_underpopulation)

      expect(cell.next_status).to eq(:dead)
    end

    it "with two or three live neighbours will be alive" do
      cell = Cell.new(:alive)

      cell.set_live_neighbours(3)

      expect(cell.next_status).to eq(:alive)
    end

    it "with more than three live neighbours will die (overcrowding)" do
      cell = Cell.new(:alive)

      min_neighbours_for_overcrowding = 4

      cell.set_live_neighbours(min_neighbours_for_overcrowding)

      expect(cell.next_status).to eq(:dead)
    end

  end

  context "is dead" do
    it "with exactly three live neighbours becomes a live cell" do
      cell = Cell.new(:dead)

      cell.set_live_neighbours(3)

      expect(cell.next_status).to eq(:alive)
    end
  end
end
