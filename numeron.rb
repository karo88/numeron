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
      @secret.zip(call).each do |secret_digit, call_digit|
        eat += 1 if secret_digit == call_digit
      end
      eat
    end

    def judge_bite(call)
      (@secret & call).size - judge_eat(call)
    end
  end
end
