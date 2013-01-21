module Numeron
  class Game
    def initialize(secret_length = 3)
      @secret_length = secret_length
    end

    def possible_secrets
      (0..9).to_a.permutation(@secret_length).to_a
    end
  end

  class Player
    def initialize(game, secret = nil)
      @game = game
      @secret = secret || pick_secret
    end

    def pick_secret
      @game.possible_secrets.sample
    end

    def judge(call)
      eat  = judge_eat(call)
      bite = judge_bite(call)
      [eat, bite]
    end

    def judge_eat(call)
      eat = 0
      @secret.size.times do |digit|
        eat += 1 if @secret[digit] == call[digit]
      end
      eat
    end

    def judge_bite(call)
      (@secret & call).size - judge_eat(call)
    end
  end
end

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

