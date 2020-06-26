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

  describe "#column_full?" do
    
    it "returns true when a column is full" do
      6.times { subject.place_token(1) }
      expect(subject.column_full?(1)).to be_truthy
    end

    it "returns false when a column is not full" do
      3.times { subject.place_token(1) }
      expect(subject.column_full?(1)).to be_falsy
    end
  end

  describe "#get_move" do

    context "when given input within correct range (1 - 7)" do

      it "asks for input once" do
        allow(subject).to receive(:gets) { "5" }
        expect { subject.get_move }.to output.to_stdout
      end

      it "returns input as an integer" do
        allow(subject).to receive(:gets) { "5" }
        expect(subject.get_move).to eql(5)
      end

    end

    it "works with place_token" do
      allow(subject).to receive(:gets) { "5" }
      subject.place_token(subject.get_move)
      expect(subject.board[[1, 5]]).not_to be_nil
    end

    it "checks for full columns" do
      5.times { subject.place_token(1) }
      called = false
      allow(subject).to receive(:gets) { "1" }
      expect(subject).to receive(:column_full?).with(1)
      subject.get_move
    end

  end

  describe "#switch_turn" do

    it "can change current player from 1, to 2" do
      subject.switch_turn
      expect(subject.turn).to eql(2)
    end

    it "can change current player from 2, to 1" do
      subject.switch_turn
      subject.switch_turn
      expect(subject.turn).to eql(1)
    end

  end

  describe "#multi_move" do

    it "can place several moves" do
      subject.multi_move(1, 2, 3, 4, 5, 6)
      expect(subject.board[[1, 1]]).not_to be_nil
      expect(subject.board[[1, 2]]).not_to be_nil
      expect(subject.board[[1, 3]]).not_to be_nil
      expect(subject.board[[1, 4]]).not_to be_nil
      expect(subject.board[[1, 5]]).not_to be_nil
      expect(subject.board[[1, 6]]).not_to be_nil
    end
  end

  describe "#check_win" do

    context "win condition is true" do
      
      it "returns true for horizontal win" do
        subject.multi_move(1, 1, 2, 1, 3, 1, 4)
        expect(subject.check_win(1)).to eql(true)
      end

      it "returns true for vertical win" do
        subject.multi_move(1, 2, 1, 2, 1, 2, 1)
        expect(subject.check_win(1)).to eql(true)
      end 

      it "returns true for diagonal win" do
        subject.multi_move(1, 2, 2, 3, 3, 4, 3, 4, 5, 4, 4)
        expect(subject.check_win(1)).to eql(true)
      end

    end

    context "win condition is false" do

    end
  end

  describe "#check_four" do

    it "returns win value when passed an array with 4 consecutive values" do
      expect(subject.check_four([1, 2, 2, 1, 1, 1, 1])).to eql(1)
    end

    it "returns nil when passed an array without 4 consecutive values" do
      expect(subject.check_four([1, 2, 1, 1, 1, 2, 2])). to eql(nil)
    end

    it "returns nil when passes an array with length less than 4" do
      expect(subject.check_four([1,1,1])).to eql(nil)
    end

  end

end
