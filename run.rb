require File.expand_path '../game_of_life', __FILE__

def play(iterations)
  game = Game.new(40, 20)
  # oscillators:
  # game.load [2,20], [2,21], [2,22]
  # game.load [2,10], [2,11], [2,12], [3,9], [3,10], [3,11]
  # glider:
  game.load [2,1], [2,2], [2,3], [1,3], [0,2]
  n = 0
  while n < iterations
    print "\e[2J\e[f"
    puts game.to_s.gsub('0', ' ').gsub('1', '@')
    game.tick
    sleep 0.1
    n+=1
  end
end

play(150)
