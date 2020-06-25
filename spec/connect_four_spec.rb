require './lib/connect_four.rb'

describe Game do
  subject { Game.new }

  describe "#initialize" do
    
    it "sets up a new Game obj" do
      expect(subject).to be_kind_of(Game)
    end

    it "builds a board on creation and assigns it to instance variable" do
      expect(subject.board).not_to be_nil
      expect(subject.board).to be_kind_of(Hash)
    end

    it "sets up players variable as a hash" do
      expect(subject.players).not_to be_nil
      expect(subject.players).to be_kind_of(Hash)
    end

    it "has default player values of 'O' and 'X'" do
      expect(subject.players[1]).to eql('O')
      expect(subject.players[2]).to eql('X')
    end

    it "can take custom arguments for player tokens" do
      game = Game.new('G', 'E')
      expect(game.players[1]).to eql('G')
      expect(game.players[2]).to eql('E')
    end

    it "tracks whos turn it is, beginning with player 1" do
      expect(subject.turn).to eql(1)
    end

  end

  describe "#build_board" do
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

  describe "#txt" do
    let(:text) { subject.txt}

    it "returns a string" do
      expect(text).to be_kind_of(String)
    end

    it "represents game cells as [ ]" do
      expect(text).to match(/[  ]/)
    end

    it "is formatted using new lines" do
      expect(text).to match(/\n/)
    end

    it "numbers the columns 1-7" do
      expect(text). to match(/[1234567]/)
    end

  end

  describe "#place_token" do

    context "when board is empty" do

      it "places a token in the lowest free slot of a column" do
        subject.place_token(1)
        expect(subject.board[[1, 1]]).to eql(subject.players[1])
      end
    end

    context "when board has some existing tokens" do
      before(:each) { 4.times {subject.place_token(1)} }

      it "places a token in the lowest free slot of a column" do
        subject.place_token(1)
        expect(subject.board[[5, 1]]).to eql('O')
      end
    end
    
  end

end
