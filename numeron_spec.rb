require_relative './game'
require_relative './player'

describe Numeron::Player do
  context "secret is [1, 2, 3]" do
    before do
      game = Numeron::Game.new
      @player = Numeron::Player.new(game, [1, 2, 3])
    end
    it { @player.judge_eat([1, 2, 3]).should == 3 }
    it { @player.judge_eat([4, 5, 6]).should == 0 }
    it { @player.judge_eat([1, 5, 6]).should == 1 }
    it { @player.judge_eat([0, 2, 3]).should == 2 }

    it { @player.judge_bite([2, 4, 5]).should == 1 }
    it { @player.judge_bite([2, 4, 1]).should == 2 }
    it { @player.judge_bite([2, 1, 3]).should == 2 }
    it { @player.judge_bite([1, 2, 0]).should == 0 }

    it { @player.judge([1, 2, 3]).should == [3, 0] }
    it { @player.judge([4, 3, 2]).should == [0, 2] }
  end
end
