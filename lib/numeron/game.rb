module Numeron
  class Game
    def initialize(secret_length = 3)
      @secret_length = secret_length
    end

    def possible_secrets
      (0..9).to_a.permutation(@secret_length).to_a
    end
  end
end
