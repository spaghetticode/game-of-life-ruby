class Game
  LIVE = [2,3]
  BORN = [3]

  attr_accessor :grid, :cols, :rows

  def initialize(cols, rows)
    @cols, @rows = cols, rows
    @grid = build_grid
  end

  def load(*cells)
    cells.each {|y,x| grid[y][x] = 1}
  end

  def to_s
    grid.inject('') do |s, rows|
      rows.each {|cell| s << cell.to_s}
      s << "\n"
    end
  end

  def live_neighbors_count(y,x)
    neighbors(y,x).select {|cell| cell == 1}.size
  end

  def tick
    new_grid = build_grid
    grid.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        count = live_neighbors_count(y,x)
        new_grid[y][x] = begin
          if cell.zero?
            BORN.include?(count) ? 1 : 0
          else
            LIVE.include?(count) ? 1 : 0
          end
        end
      end
    end
    @grid = new_grid
  end

  private

  def build_grid
    Array.new(rows) { Array.new(cols, 0) }
  end

  def neighbors(y, x)
    (-1..1).inject [] do |values, py|
      (-1..1).each do |px|
        unless py == 0 and px == 0
          i = y + py
          j = x + px
          i = 0 unless i < rows
          j = 0 unless j < cols
          values << grid[i][j]
        end
      end
      values
    end
  end
end

def play(iterations)
  game = Game.new(40, 10)
  # oscillators:
  # game.load [2,20], [2,21], [2,22]
  # game.load [2,10], [2,11], [2,12], [3,9], [3,10], [3,11]
  # glider:
  # game.load [2,1], [2,2], [2,3], [1,3], [0,2]
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
