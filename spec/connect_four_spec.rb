require "connect_four"

describe ConnectFour do
  let(:c_four) { ConnectFour.new }

  describe "#initialize" do
    it "creates the players correctly" do
      expect(c_four.player1.mark).to eql("\u25CB")
      expect(c_four.player2.mark).to eql("\u25CF")
    end
  end  
end
