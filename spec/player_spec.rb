require "player"

describe Player do
  let (:player) { Player.new("\u25CB") }

  before do
    $stdout = File.new('/dev/null', 'w')
  end

  describe "#initialize" do
    it "expects the player's mark to be \u25CB" do
      expect(player.mark).to eql("\u25CB")
    end
  end

  describe ".get_next_move" do
    context "user input is between 1 and 7" do
      it "returns the number the user inputs - 1" do
        allow(player).to receive(:gets).and_return("1")
        expect(player.get_next_move).to eql(0)
      end
    end
  end
end
