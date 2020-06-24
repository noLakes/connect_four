require './lib/connect_four.rb'

describe Game do
  subject { Game.new }

  xdescribe "#build_board" do
    let(:board) { subject.build_board}

    it "returns a hash" do
      expect(board).to be_kind_of(Hash)
    end

    it "has 42 key/val pairs (for each position)" do
      expect(board.length).to eql(42)
    end

    it "has no duplicate positions" do
      expect(board.keys.uniq.length).to eql(42)
    end

    it "stores the position keys as arrays" do
      expect(board.keys).to all(be_an(Array))
    end

    it "has first position [1, 1], and last position [6, 7]" do
      expect(board.keys).to include([1, 1])
      expect(board.keys).to include([6, 7])
    end

    it "has initial values as nil" do
      expect(board.values).to all(be_nil)
    end
  end

end
